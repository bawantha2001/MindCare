import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class DoExcersiceScreen extends StatefulWidget {
  final String exName;
  final String videoUrl;
  const DoExcersiceScreen({super.key,required this.exName,required this.videoUrl});

  @override
  State<DoExcersiceScreen> createState() => _DoExcersiceScreenState();
}

class _DoExcersiceScreenState extends State<DoExcersiceScreen> {

  List<String>? selectedYogaOrmed;

  List<String> exeChairDancing = [
  'Sit upright in a sturdy chair.',
  "Play upbeat music.",
  "Move arms, legs, and torso to the rhythm.",
  "Clap, tap feet, twist, or sway safely.",
  "Keep moving and enjoy for a few minutes.",
  ];

  List<String> exeSlowWaking = [
  "Stand tall and relaxed.",
  "Walk slowly, step by step.",
  "Feel each foot touch the ground.",
  "Breathe gently.",
  "Focus on each movement."

  ];

  List<String> exeSqueezingaSoft = [
  "Hold ball in your hand.",
  "Squeeze tightly.",
  "Hold for a few seconds.",
  "Release slowly.",
  "Repeat 10–15 times each hand."

  ];

  List<String> exeTaiChi = [
  'Stand with soft knees.',
  "Move slowly and smoothly.",
  "Shift weight gently.",
  "Flow arms like water.",
  "Breathe deeply and stay calm."

  ];

  List<String> exeSeatedLegAndArm = [
  "Sit tall in a chair.",
  "Lift one leg, then lower.",
  "Raise both arms overhead, then down.",
  "Repeat slowly.",
  "Alternate sides."

  ];

  YoutubePlayerController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.exName == "Chair Dancing"?selectedYogaOrmed = exeChairDancing:widget.exName == "Slow Walking"?selectedYogaOrmed = exeSlowWaking:widget.exName == "Squeezing a Soft Stress Ball"?selectedYogaOrmed = exeSqueezingaSoft:widget.exName == "Tai Chi"?selectedYogaOrmed = exeTaiChi:selectedYogaOrmed = exeSeatedLegAndArm;
    _controller = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(widget.videoUrl)??"",
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.exName}"),
        leading: GestureDetector(onTap:() {
          Navigator.pop(context);
        },
            child: Icon(Icons.arrow_back_ios_rounded,color: Colors.blue,)
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15,top: 15,right: 15,bottom: 2),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:Column(
          children: [
            YoutubePlayer(
              controller: _controller!,
              aspectRatio: 16 / 9,
            ),

            SizedBox(height: 15,),

            Flexible(
              child: GridView.builder(
                itemCount: selectedYogaOrmed?.length??0,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10
                ),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    width: 165,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            width: 1,
                            color: Colors.blue
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(child: Image.asset("assets/images/yoga 1.png",)),
                        SizedBox(height: 10,),
                        Flexible(child: Text("Step ${index+1}: ${selectedYogaOrmed?.elementAt(index)}"??"",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),)),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
