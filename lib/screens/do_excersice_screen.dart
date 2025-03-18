import 'package:flutter/material.dart';

class DoExcersiceScreen extends StatefulWidget {
  final String exName;
  const DoExcersiceScreen({super.key,required this.exName});

  @override
  State<DoExcersiceScreen> createState() => _DoExcersiceScreenState();
}

class _DoExcersiceScreenState extends State<DoExcersiceScreen> {
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
        padding: EdgeInsets.all(30),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:Column(
          children: [
            SizedBox(height: 10,),
            Flexible(
              child: Container(
                height: 195,
                width: 346,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue,width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.play_circle,size: 50,color: Color.fromRGBO(64, 124, 226, 1),),
                    SizedBox(height: 5,),
                    Text("Play the Video",style: TextStyle(fontWeight: FontWeight.w800),)
                  ],
                ),
              ),
            ),

            SizedBox(height: 30,),

            Flexible(
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 195,
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
                          Flexible(child: Image.asset("assets/images/img3.png",)),
                          SizedBox(height: 10,),
                          Flexible(child: Text("Step 1",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8,),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 195,
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
                          Flexible(child: Image.asset("assets/images/sit-up 1.png",)),
                          SizedBox(height: 10,),
                          Flexible(child: Text("Step 2",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8,),

            Flexible(
              child: Container(
                padding: EdgeInsets.all(10),
                height: 195,
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
                    Flexible(child: Image.asset("assets/images/running 1.png",)),
                    SizedBox(height: 10,),
                    Flexible(child: Text("Step 3",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),)),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
