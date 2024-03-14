import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Main/LoginMainPage.dart';
import 'package:project/Main/MainHome.dart';

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
    // Simulate some delay (e.g., fetching data, loading resources)
    await Future.delayed(Duration(seconds: 2));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/instagram.png',
              width: 400,
              height: 250,
              fit: BoxFit.cover,
            ),
            CircularProgressIndicator(color: Colors.blue,)
          ],
        ),
      ),
    );
  }
}
