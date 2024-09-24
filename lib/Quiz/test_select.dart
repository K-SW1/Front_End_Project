import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Quiz/all_test.dart';
import 'package:project/Quiz/test_Quizlist.dart';

import 'package:project/components/custom_appbar.dart';
import 'package:project/components/custom_banner.dart';
import 'package:project/components/custom_bottomNavigation.dart';

class Alltest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 400,
              height: 216,
            ),
            Divider(thickness: 3, color: Colors.black),
            InkWell(
              onTap: () {
                Get.to(() => Allquiz1());
              },
              child: Container(
                width: 400,
                height: 100,
                color: Colors.white10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.quiz,
                      size: 45,
                      color: Colors.black,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "이미지 문제 풀기",
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
                Get.to(() => QuizPage());
              },
              child: Container(
                width: 400,
                height: 100,
                color: Colors.white10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.list_alt_rounded,
                      size: 45,
                      color: Colors.black,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "문자 문제 풀기",
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
