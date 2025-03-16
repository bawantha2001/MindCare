import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tflite_v2/tflite_v2.dart';

class ScanService extends GetxController{

  @override
  void onInit(){
    super.onInit();
    initCamera();
    initTFLite();
  }

  @override
  void dispoce(){
    super.dispose();
    cameraController.dispose();
    Tflite.close();
  }


  late CameraController cameraController;
  late List<CameraDescription> cameras;

  late CameraImage cameraImage;

  var isCameraInitialized = false.obs;
  var cameraCount = 0;

  var detectedObject = "".obs;
  String lastSpokenObject = '';


  void updateDetectedObject(String newObject) {
    if (newObject != lastSpokenObject) {
      detectedObject.value = newObject;
      lastSpokenObject = newObject;
    }
  }

  closeTflite()async{
    await Tflite.close();
  }

  initCamera() async{
    if(await Permission.camera.request().isGranted){
      cameras = await availableCameras();
      
      cameraController = await CameraController(
          cameras[0],
          ResolutionPreset.max);
      await cameraController.initialize().then((onValue){
          cameraController.startImageStream((image){
            cameraCount ++;
            if(cameraCount %10 == 0){
              cameraCount = 0;
              objectDetector(image);
            }

          });
      });
      isCameraInitialized(true);
      update();
    }
    else{
      print("Permission denied");
    }
  }

  initTFLite() async{
    try{
      await Tflite.loadModel(
          model: "assets/model.tflite",
          labels: "assets/labels.txt",
          isAsset:true,
          numThreads: 1,
          useGpuDelegate: false
      );
    }catch(ex){
      print(ex);
    }

  }
  
  objectDetector(CameraImage image) async{
    try{
      var detector = await Tflite.runModelOnFrame(
          bytesList: image.planes.map((e){
            return e.bytes;
          }).toList(),
          asynch: true,
          imageHeight: image.height,
          imageWidth: image.width,
          imageMean: 127.5,
          imageStd: 127.5,
          numResults: 1,
          rotation: 90,
          threshold: 0.4
      );

      if(detector != null){
        if(detector[0]['confidence']>=0.89 && detector[0]['confidence']<0.9999064207077026){
          String label = detector[0]['label'];
          detectedObject.value = label.replaceAll(RegExp(r'[0-9]'), '');
          update();
          print("Result is $label");
        }
        else{
          detectedObject.value = "";
          update();
          print("Detecting objects...");
        }
      }
    }catch(ex){
      print("Exception ${ex}");
    }
  }

}