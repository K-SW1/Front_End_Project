import 'package:flutter/material.dart';
import 'package:project/components/custom_appbar.dart';
import 'package:project/components/custom_banner.dart';
import 'package:project/components/custom_textquiz_form.dart';

class TextQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color appBarColor = Color.fromRGBO(121, 159, 165, 1.0);
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  "우리 가족 퀴즈 문제 등록",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 100),
                Text(
                  "문제 내용",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomTextForm(),
                SizedBox(height: 46),
                Text(
                  "힌트 내용",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomTextForm(),
                Text("\n\n\n\n\n\n\n\n\n"),

                SizedBox(height: 30),
                Container(
                  height: 140,
                  child: CustomBanner(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: appBarColor,
        unselectedItemColor: appBarColor,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.phone, size: 35), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 35), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 35), label: ""),
        ],
      ),
    );
  }
}
