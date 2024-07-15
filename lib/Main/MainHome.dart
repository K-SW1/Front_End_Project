// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:project/Calender/calender.dart';
// import 'package:project/Main/Second.dart';
// import 'package:project/Quiz/QuizSelect.dart';
// import 'package:project/aasd/teste.dart';
// import 'package:project/components/custom_banner.dart';
// import 'package:project/components/custom_appbar.dart';
// import 'package:project/components/custom_bottomNavigation.dart';
//
// void main() => runApp(MainHome());
//
// class MainHome extends StatefulWidget {
//   const MainHome({Key? key}) : super(key: key);
//
//   @override
//   State<MainHome> createState() => _MainHomeState();
// }
//
// class _MainHomeState extends State<MainHome> {
//   @override
//   Widget build(BuildContext context) {
//     Color appBarColor = Color.fromRGBO(121, 159, 165, 1.0);
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Home(),
//     );
//   }
// }
//
// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Color appBarColor = Color.fromRGBO(121, 159, 165, 1.0);
//     return Scaffold(
//       appBar: CustomAppBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             InkWell(
//               onTap: () {
//                 Get.to(() => CalenderApp());
//               },
//               child: Container(
//                 width: 400,
//                 height: 100,
//                 color: Colors.white10,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Icon(
//                       Icons.calendar_month,
//                       size: 45,
//                       color: Colors.black,
//                     ),
//                     SizedBox(width: 20),
//                     Text(
//                       "돌봄 다이어리",
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
//             Divider(thickness: 3, color: Colors.black),
//
//             InkWell(
//               onTap: () {
//                 Get.to(() => CenterSearch());
//               },
//               child: Container(
//                 width: 400,
//                 height: 100,
//                 color: Colors.white10,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Icon(
//                       Icons.grain,
//                       size: 40,
//                       color: Colors.black,
//                     ),
//                     SizedBox(width: 20),
//                     Text(
//                       "데이케어 센터 검색",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 40,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Divider(thickness: 3, color: Colors.black),
//             InkWell(
//               onTap: () {
//                 Get.to(() => QuizSelect());
//               },
//               child: Container(
//                 width: 400,
//                 height: 100,
//                 color: Colors.white10,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Icon(
//                       Icons.family_restroom,
//                       size: 40,
//                       color: Colors.black,
//                     ),
//                     SizedBox(width: 20),
//                     Text(
//                       "우리 가족 퀴즈",
//                       textAlign: TextAlign.start,
//                       style: TextStyle(
//                         fontSize: 40,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Divider(thickness: 3, color: Colors.black),
//             InkWell(
//               onTap: () {
//                 Get.to(() => Second());
//               },
//               child: Container(
//                 width: 400,
//                 height: 100,
//                 color: Colors.white10,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Icon(
//                       Icons.emoji_people,
//                       size: 40,
//                       color: Colors.black,
//                     ),
//                     SizedBox(width: 20),
//                     Text(
//                       "어르신 길 잃음 방지",
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
//             Divider(thickness: 3, color: Colors.black),
//             SizedBox(height: 23,),
//             Container(
//               height: 140,
//               child: CustomBanner(),
//             ),
//           ],
//         ),
//       ),
//
//       bottomNavigationBar: BottomNavigationBar(
//         elevation: 5,
//         selectedItemColor: appBarColor,
//         unselectedItemColor: appBarColor,
//         selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
//         unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(icon: Icon(Icons.phone, size: 45), label: ""),
//           BottomNavigationBarItem(icon: Icon(Icons.home, size: 45), label: ""),
//           BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 45), label: ""),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Calender/calender.dart';
import 'package:project/Main/Second.dart';
import 'package:project/Quiz/QuizSelect.dart';
import 'package:project/aasd/teste.dart';
import 'package:project/components/custom_banner.dart';
import 'package:project/components/custom_appbar.dart';
import 'package:project/components/custom_bottomNavigation.dart';

void main() => runApp(MainHome());

class MainHome extends StatelessWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
                    )
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
                    )
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
                    )
                  ],
                ),
              ),
            ),
            Divider(thickness: 3, color: Colors.black),
            SizedBox(height: 23,),
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
