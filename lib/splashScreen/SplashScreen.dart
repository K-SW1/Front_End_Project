
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xff6EA0A7)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      'assets/recall_splash.png'),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                        Colors.white
                    ),
                  )
                ],
              )
            ],
            ),
          ),
        ),
      );
  }

}