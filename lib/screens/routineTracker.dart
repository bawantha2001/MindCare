import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:tflite_v2/tflite_v2.dart';

import '../services/scan_service.dart';

class Routinetracker extends StatefulWidget {

  @override
  State<Routinetracker> createState() => _CurrencyDetectorScreen();
}

class _CurrencyDetectorScreen extends State<Routinetracker> {
 final ScanService scanService = Get.put(ScanService());
 final FlutterTts _flutterTts = FlutterTts();


  TTSService() {
    _initializeTTS();
  }

 @override
 void dispoce(){
   super.dispose();
   scanService.cameraController.dispose();
   Tflite.close();
 }

  Future<void> _initializeTTS() async {
    await _flutterTts.setLanguage("en-US"); // Set language
    await _flutterTts.setPitch(2.0); // Adjust pitch
    await _flutterTts.setSpeechRate(0.5); // Adjust speed
  }

  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        speak("back to main menu");
        return true;
      },
      child: Scaffold(
        body:GetBuilder<ScanService>(
          init: ScanService(),
          builder: (controller) {
            if (controller.detectedObject.value.isNotEmpty) {
              if (controller.detectedObject.value != controller.lastSpokenObject) {
                controller.lastSpokenObject = controller.detectedObject.value;
                speak("Detected ${controller.detectedObject.value}");
              }
            }

            return Stack(
              children: [
                controller.isCameraInitialized.value?Container(height: double.infinity,child: CameraPreview(controller.cameraController))
                    :Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                    ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1,color: Colors.green),
                          color: Colors.black.withOpacity(0.5),
                        ),

                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(child: scanService.detectedObject.value.isNotEmpty?Text("💵: ${controller.detectedObject.value}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),)
                                :Text("⚠️: Not Detected",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                scanService.detectedObject.value.isEmpty?
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitWave(
                        color: Colors.green,
                        size: 35,
                      ),
                      SizedBox(height: 5,),
                      Text("📡 Scanning For Currencies",style:  TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),)
                    ],
                  ),
                ):SizedBox()
              ],
            );
          }
        )
      ),
    );
  }
}
