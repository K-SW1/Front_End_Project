import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Dementia/DementiaTest.dart';
import 'package:project/Login/LoginMain.dart';
import 'package:project/Login/LoginPage.dart';
import 'package:project/Regist/RegistAgree.dart';

void main() => runApp(GetMaterialApp(
  debugShowCheckedModeBanner: false,
  home: LoginPage(),
));

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color appBarColor = Color.fromRGBO(121, 159, 165, 1.0);
    return Scaffold(
      backgroundColor: appBarColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),

            InkWell(
              onTap: () {
                Get.off(() => LoginScreen());
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 70),
                width: 180,
                height: 100,
                child: Center(
                  child: Text(
                    "로그인",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(color: Colors.black, width: 3),
                  color: Colors.white,
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Get.off(() => IdRegist());
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: 180,
                height: 100,
                child: Center(
                  child: Text(
                    "회원가입",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(color: Colors.black, width: 3),
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 60),

            InkWell(
              onTap: () {
                Get.off(() => DementiaTest());
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: 180,
                height: 100,
                child: Center(
                  child: Text(
                    "치매테스트",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(color: Colors.black, width: 3),
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 90),

            Image.asset("assets/images/recall_splash.png", height: 40),
          ],
        ),
      ),
    );
  }
}
