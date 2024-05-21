import 'package:flutter/material.dart';

class Second extends StatelessWidget {
  const Second({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Second",style: TextStyle(color: Colors.black),),
        ),
        body: Center(
          child: Container(
            width: 150,
            height: 150,
            color: Colors.black,
          ),
        ),
        // body: Container(
        //   width: 150,
        //   height: 150,
        //   color: Colors.black,
        // ),
      ),
    );
  }
}
