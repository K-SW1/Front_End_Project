import 'package:flutter/material.dart';

import 'package:project/Main/LoginMainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color appBarColor = Color.fromRGBO(121,159,165,1.0);
    return Container(
      color: appBarColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/recall_splash.png',
              fit: BoxFit.contain,
            ),
            Text("\n"),
            CircularProgressIndicator(color: Colors.white,)
          ],
        ),
      ),
    );
  }
}
