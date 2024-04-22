import 'package:flutter/material.dart';

class Third extends StatelessWidget {
  const Third({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Third",style: TextStyle(color: Colors.black),),
        ),
        body: Container(
          width: 150,
          height: 150,
          color: Colors.black,
        ),
      ),
    );
  }
}
