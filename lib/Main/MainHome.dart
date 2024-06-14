// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:project/Calender/calender.dart';
// import 'package:project/Main/Second.dart';
// import 'package:project/Quiz/QuizSelect.dart';
// import 'package:project/aasd/teste.dart';
// import 'package:project/components/custom_banner.dart';
// import 'package:project/components/custom_appbar.dart';
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
//             Text("\n\n\n\n\n"),
//             Container(
//               height: 140,
//               child: CustomBanner(),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         elevation: 5,
//         selectedItemColor: appBarColor,
//         unselectedItemColor: appBarColor,
//         selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
//         unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(icon: Icon(Icons.phone, size: 45), label: ""),
//           BottomNavigationBarItem(icon: Icon(Icons.home, size: 45), label: ""),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.account_circle, size: 45), label: ""),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:developer' show log;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Calender/calender.dart';
import 'package:project/Main/Second.dart';
import 'package:project/Quiz/QuizSelect.dart';
import 'package:project/aasd/teste.dart';
import 'package:project/components/custom_banner.dart';
import 'package:project/components/custom_appbar.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import '../components/custom_textquiz_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeNaverMap();
  runApp(MainHome());
}

Future<void> _initializeNaverMap() async {
  await NaverMapSdk.instance.initialize(
    clientId: 'ckwq0q1fl6',
    onAuthFailed: (ex) => log("********* 네이버맵 인증오류 : $ex *********"),
  );
}

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    Color appBarColor = Color.fromRGBO(121, 159, 165, 1.0);
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
            _buildMenuItem(
              context,
              icon: Icons.calendar_month,
              label: "돌봄 다이어리",
              onTap: () {
                Get.to(() => CalenderApp());
              },
            ),
            Divider(thickness: 3, color: Colors.black),
            _buildMenuItem(
              context,
              icon: Icons.grain,
              label: "데이케어 센터 검색",
              onTap: () {
                Get.to(() => CenterSearch());
              },
            ),
            Divider(thickness: 3, color: Colors.black),
            _buildMenuItem(
              context,
              icon: Icons.family_restroom,
              label: "우리 가족 퀴즈",
              onTap: () {
                Get.to(() => QuizSelect());
              },
            ),
            Divider(thickness: 3, color: Colors.black),
            _buildMenuItem(
              context,
              icon: Icons.emoji_people,
              label: "어르신 길 잃음 방지",
              onTap: () {
                Get.to(() => Second());
              },
            ),
            Divider(thickness: 3, color: Colors.black),
            SizedBox(height: 101),
            Container(
              height: 140,
              child: CustomBanner(),
            ),
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
          BottomNavigationBarItem(icon: Icon(Icons.phone, size: 45), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 45), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, size: 45), label: ""),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required IconData icon,
        required String label,
        required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 400,
        height: 100,
        color: Colors.white10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: Colors.black),
            SizedBox(width: 20),
            Text(
              label,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CenterSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "데이케어 센터 검색",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                CustomTextForm(),
                SizedBox(height: 20),
                CenterSearchMap(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CenterSearchMap extends StatefulWidget {
  @override
  _CenterSearchMapState createState() => _CenterSearchMapState();
}

class _CenterSearchMapState extends State<CenterSearchMap> {
  late NaverMapController _mapController;
  final Completer<NaverMapController> mapControllerCompleter = Completer();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final pixelRatio = mediaQuery.devicePixelRatio;
    final mapSize = Size(mediaQuery.size.width - 50, mediaQuery.size.height / 2);
    final physicalSize = Size(mapSize.width * pixelRatio, mapSize.height * pixelRatio);

    print("physicalSize: $physicalSize");

    return SizedBox(
      width: mapSize.width,
      height: mapSize.height,
      child: NaverMap(
        options: const NaverMapViewOptions(
          indoorEnable: true,
          locationButtonEnable: false,
          consumeSymbolTapEvents: false,
        ),
        onMapReady: (controller) async {
          _mapController = controller;
          mapControllerCompleter.complete(controller);
          log("onMapReady", name: "onMapReady");
        },
      ),
    );
  }
}
