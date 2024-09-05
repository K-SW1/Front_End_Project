// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:project/Main/Second.dart';
// import 'package:project/Quiz/Quiz.dart';
// import 'package:project/Quiz/QuizRegister.dart';
// import 'package:project/aasd/test_quiz.dart';
// import 'package:project/components/custom_appbar.dart';
// import 'package:project/components/custom_banner.dart';
// import 'package:project/components/custom_bottomNavigation.dart';
//
// class QuizSelect extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Color appBarColor = Color.fromRGBO(121, 159, 165, 1.0);
//     return Scaffold(
//       appBar: CustomAppBar(),
//       body: Center(
//         child: Column(
//           children: [
//             Container(
//               width: 400,
//               height: 216,
//             ),
//             Divider(thickness: 3,color: Colors.black,),
//             InkWell(
//               onTap: () {
//                 Get.to(()=> QuizListScreen());
//               },
//               child: Container(
//                 width: 400,
//                 height: 100,
//                 color: Colors.white10,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Icon(
//                       Icons.quiz_rounded,
//                       size: 45,
//                       color: Colors.black,
//                     ),
//                     SizedBox(width: 20),
//                     Text(
//                       "문제 풀기",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 40,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Divider(thickness: 3,color: Colors.black,),
//             InkWell(
//               onTap: () {
//                 Get.to(() => QuizRegister());
//               },
//               child: Container(
//                 width: 400,
//                 height: 100,
//                 color: Colors.white10,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Icon(
//                       Icons.question_mark,
//                       size: 45,
//                       color: Colors.black,
//                     ),
//                     SizedBox(width: 20),
//                     Text(
//                       "문제 등록",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 40,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Divider(thickness: 3,color: Colors.black),
//             SizedBox(height: 23,),
//             Container(
//               height: 140,
//               child: CustomBanner(),
//             )
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottom(),
//     );
//   }
// }
//
// void main() => runApp(MaterialApp(home: QuizSelect()));


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Quiz/QuizRegister.dart';
import 'package:project/Quiz/all_test.dart';
import 'package:project/Quiz/test_quiz.dart';
import 'package:project/Quiz/test_select.dart';
import 'package:project/components/custom_appbar.dart';
import 'package:project/components/custom_banner.dart';
import 'package:project/components/custom_bottomNavigation.dart';
import 'package:project/Quiz/Quiz.dart';

import '../aasd/Qu.dart'; // QuizListScreen을 사용하기 위해 추가

// 퀴즈 선택 화면
class QuizSelect extends StatelessWidget {

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
                Get.to(() => Alltest());
              },
              child: Container(
                width: 400,
                height: 100,
                color: Colors.white10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.quiz_rounded,
                      size: 45,
                      color: Colors.black,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "문제 풀기",
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
                Get.to(() => QuizRegister());
              },
              child: Container(
                width: 400,
                height: 100,
                color: Colors.white10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.question_mark,
                      size: 45,
                      color: Colors.black,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "문제 등록",
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
