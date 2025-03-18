import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medication/screens/do_excersice_screen.dart';

class ExcersiceScreen extends StatefulWidget {
  final String faceType;
  const ExcersiceScreen({super.key,required this.faceType});

  @override
  State<ExcersiceScreen> createState() => _ExcersiceScreenState();
}

class _ExcersiceScreenState extends State<ExcersiceScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("All Exercisices"),
        leading: GestureDetector(onTap:() {
          Navigator.pop(context);
        },
            child: Icon(Icons.arrow_back_ios_rounded,color: Colors.blue,)
        ),
      ),
      body: Container(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 76,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey,width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Text(widget.faceType=='Happy'?"Chair Dancing":widget.faceType=='Sad'?"Slow Walking":"Squeezing a Soft Stress Ball",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                      Spacer(),
                      ElevatedButton(
                        onPressed: (){
                          Get.to(DoExcersiceScreen(exName: widget.faceType=='Happy'?"Chair Dancing":widget.faceType=='Sad'?"Slow Walking":"Squeezing a Soft Stress Ball"));
                        },
                        child: Text("Start"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.all(10),
                  height: 76,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey,width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Text(widget.faceType=='Happy'?"Tai Chi":widget.faceType=='Sad'?"Slow Walking":"Seated Leg & Arm Movements",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                      Spacer(),
                      ElevatedButton(
                        onPressed: (){
                          Get.to(DoExcersiceScreen(exName: widget.faceType=='Happy'?"Tai Chi":widget.faceType=='Sad'?"Slow Walking":"Seated Leg & Arm Movements"));
                        },
                        child: Text("Start"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
