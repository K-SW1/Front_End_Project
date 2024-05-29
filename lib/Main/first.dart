import 'package:flutter/material.dart';

class first extends StatelessWidget {
  const first({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("First",style: TextStyle(color: Colors.black),),
        ),
        body: Center(
          child: Container(
            width: 150,
            height: 150,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
