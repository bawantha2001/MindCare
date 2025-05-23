import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medication/screens/do_yoga_med_screen.dart';

class YogaMeditaionScreen extends StatefulWidget {
  final String faceType;
  const YogaMeditaionScreen({super.key,required this.faceType});

  @override
  State<YogaMeditaionScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<YogaMeditaionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Yoga and Meditations"),
        leading: GestureDetector(onTap:() {
          Navigator.pop(context);
        },
            child: Icon(Icons.arrow_back_ios_rounded,color: Colors.blue,)
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: ContainedTabBarView(
            tabs: [
              Text('Yoga'),
              Text('Meditations'),
            ],
            views: [
              Container(
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
                            Flexible(child: Text(widget.faceType=='Happy'?"Seated Chair Yoga Sun Salutations":widget.faceType=='Sad'?"Alternate Nostril Breathing":"Bhastrika Pranayama",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),)),
                            Spacer(),
                            ElevatedButton(
                              onPressed: (){
                                Get.to(DoYogaMedScreen(exName: widget.faceType=='Happy'?"Seated Chair Yoga Sun Salutations":widget.faceType=='Sad'?"Alternate Nostril Breathing":"Bhastrika Pranayama"));
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
                            Flexible(child: Text(widget.faceType=='Happy'?"Chair Warrior II":widget.faceType=='Sad'?"Standing Chair Yoga Sun Salutations":"Chair Yoga Down Dog",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),)),
                            Spacer(),
                            ElevatedButton(
                              onPressed: (){
                                Get.to(DoYogaMedScreen(exName: widget.faceType=='Happy'?"Chair Warrior II":widget.faceType=='Sad'?"Standing Chair Yoga Sun Salutations":"Chair Yoga Down Dog"));
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
              Container(
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
                            Flexible(child: Text(widget.faceType=='Happy'?"Gratitude Reflection Meditation":widget.faceType=='Sad'?"Deep Breathing with Affirmations":"Cooling Breath",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),)),
                            Spacer(),
                            ElevatedButton(
                              onPressed: (){
                                Get.to(DoYogaMedScreen(exName: widget.faceType=='Happy'?"Gratitude Reflection Meditation":widget.faceType=='Sad'?"Deep Breathing with Affirmations":"Cooling Breath"));
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
                            Flexible(child: Text(widget.faceType=='Happy'?"Joyful Visualization":widget.faceType=='Sad'?"Body Relaxation Meditation":"Guided Relaxation",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),)),
                            Spacer(),
                            ElevatedButton(
                              onPressed: (){
                                Get.to(DoYogaMedScreen(exName: widget.faceType=='Happy'?"Joyful Visualization":widget.faceType=='Sad'?"Body Relaxation Meditation":"Guided Relaxation"));
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
            ],
            onChange: (index) => print(index),
          ),
        ),
      ),
    );
  }
}
