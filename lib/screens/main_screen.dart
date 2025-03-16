import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'routineTracker.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FlutterTts _flutterTts = FlutterTts();

  bool canVibrate = false;

  TTSService() {
    _initializeTTS();
  }

  Future<void> _initializeTTS() async {
    await _flutterTts.setLanguage("en-US"); // Set language
    await _flutterTts.setPitch(1.0); // Adjust pitch
    await _flutterTts.setSpeechRate(0.5); // Adjust speed
  }

  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
    await _flutterTts.clearVoice();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TTSService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 35,vertical: 30),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text("Welcome!",style: TextStyle(fontSize: 24,fontWeight:FontWeight.w600 ),),
                  Text("MindCare",style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: Colors.blueAccent ),),
                ],
              ),
              SizedBox(height: 100,),
              Flexible(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: [
                      GestureDetector(
                        onTap: (){
                          if(canVibrate){
                          }
                          Get.to(Routinetracker());
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromRGBO(128, 169, 239, 1),
                                  border: Border.all(width: 0.5,color: Colors.white)
                              ),
                              width: 96,
                              height: 93,
                              child: Image.asset("assets/images/pill 1.png",height: 36,width: 39,),
                            ),
                            SizedBox(height: 10,),
                            Text("Routine Tracker",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: (){
                          if(canVibrate){
                          }
                          // Get.to(CurrencyDetectorScreen());
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromRGBO(128, 169, 239, 1),
                                  border: Border.all(width: 0.5,color: Colors.white)
                              ),
                              width: 96,
                              height: 93,
                              child: Image.asset("assets/images/console 1.png",height: 36,width: 39,),
                            ),
                            SizedBox(height: 10,),
                            Text("Cognitive Monitor",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: (){
                          if(canVibrate){
                          }
                          // Get.to(CurrencyDetectorScreen());
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromRGBO(128, 169, 239, 1),
                                  border: Border.all(width: 0.5,color: Colors.white)
                              ),
                              width: 96,
                              height: 93,
                              child: Image.asset("assets/images/voice 1.png",height: 36,width: 39,),
                            ),
                            SizedBox(height: 10,),
                            Text("Smart Assistant",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: (){
                          // Get.to(CurrencyDetectorScreen());
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromRGBO(128, 169, 239, 1),
                                  border: Border.all(width: 0.5,color: Colors.white)
                              ),
                              width: 96,
                              height: 93,
                              child: Image.asset("assets/images/yoga 2.png",height: 36,width: 39,),
                            ),
                            SizedBox(height: 10,),
                            Text("Mood Companion",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                          ],
                        ),
                      ),
                    ],
                
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
