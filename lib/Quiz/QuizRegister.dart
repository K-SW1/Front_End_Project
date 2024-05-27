import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Main/Second.dart';
import 'package:project/Quiz/TextQuiz.dart';
import 'package:project/components/custom_appbar.dart';
import 'package:project/components/custom_banner.dart';

class QuizRegister extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Color appBarColor = Color.fromRGBO(121,159,165,1.0);
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 400,
              height: 216,
            ),
            Divider(thickness: 3,color: Colors.black),
            InkWell(
              onTap: () {
                Get.to(() => Second());
              },
              child: Container(
                width: 400,
                height: 100,
                color: Colors.white10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.image,
                      size: 45,
                      color: Colors.black,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "이미지 퀴즈",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(thickness: 3,color: Colors.black),
            InkWell(
              onTap: () {
                Get.to(() => TextQuiz());
              },
              child: Container(
                width: 400,
                height: 100,
                color: Colors.white10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.text_fields,
                      size: 45,
                      color: Colors.black,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "텍스트 퀴즈",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(thickness: 3,color: Colors.black,),
            Text("\n\n\n\n\n"),
            Container(
              height: 140,
              child: CustomBanner(),
            )
          ],
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
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, size: 35), label: ""),
        ],
      ),
    );
  }
}
