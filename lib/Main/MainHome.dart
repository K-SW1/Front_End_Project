import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Calender/calender.dart';
import 'package:project/Main/Second.dart';
import 'package:project/Quiz/QuizSelect.dart';
import 'package:project/aasd/teste.dart';
import 'package:project/components/custom_banner.dart';
import 'package:project/components/custom_appbar.dart';
import 'package:project/components/custom_bottomNavigation.dart';

void main() => runApp(MH());

class MH extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainHome(),
    );
  }
}

class MainHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color appBarColor = Color.fromRGBO(121, 159, 165, 1.0);
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Get.to(() => CalenderApp());
              },
              child: Container(
                width: 400,
                height: 100,
                color: Colors.white10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 45,
                      color: Colors.black,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "돌봄 다이어리",
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
            Divider(thickness: 3, color: Colors.black),
            InkWell(
              onTap: () {
                Get.to(() => CenterSearch());
              },
              child: Container(
                width: 400,
                height: 100,
                color: Colors.white10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.grain,
                      size: 40,
                      color: Colors.black,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "데이케어 센터 검색",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(thickness: 3, color: Colors.black),
            InkWell(
              onTap: () {
                Get.to(() => QuizSelect());
              },
              child: Container(
                width: 400,
                height: 100,
                color: Colors.white10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.family_restroom,
                      size: 40,
                      color: Colors.black,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "우리 가족 퀴즈",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(thickness: 3, color: Colors.black),
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
                      Icons.emoji_people,
                      size: 40,
                      color: Colors.black,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "어르신 길 잃음 방지",
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
            Divider(thickness: 3, color: Colors.black),
            SizedBox(height: 23),
            Container(
              height: 140,
              child: CustomBanner(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottom(),
    );
  }
}
