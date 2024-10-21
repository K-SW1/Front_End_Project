// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:project/Calender/calender.dart';
// import 'package:project/Missing/Missing.dart';
// import 'package:project/Quiz/QuizSelect.dart';
// import 'package:project/aasd/teste.dart';
//
// import 'package:project/components/custom_banner.dart';
// import 'package:project/components/custom_appbar.dart';
// import 'package:project/components/custom_bottomNavigation.dart';
//
// void main() => runApp(MH());
//
// class MH extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MainHome(),
//     );
//   }
// }
//
// class MainHome extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(),  // CustomAppBar이 올바르게 구현되어 있어야 합니다.
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _buildMenuItem(
//               icon: Icons.calendar_month,
//               text: "돌봄 다이어리",
//               onTap: () => Get.to(() => CalenderApp()),
//             ),
//             _buildMenuItem(
//               icon: Icons.grain,
//               text: "데이케어 센터 검색",
//               onTap: () => Get.to(() => NMAP()),
//             ),
//             _buildMenuItem(
//               icon: Icons.family_restroom,
//               text: "우리 가족 퀴즈",
//               onTap: () => Get.to(() => QuizSelect()),
//             ),
//             _buildMenuItem(
//               icon: Icons.emoji_people,
//               text: "어르신 길 잃음 방지",
//               onTap: () => Get.to(() => Missing()),
//             ),
//             SizedBox(height: 23),
//             Container(
//               height: 140,
//               child: CustomBanner(),  // CustomBanner가 올바르게 구현되어 있는지 확인하세요.
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottom(),  // CustomBottom이 올바르게 구현되어 있는지 확인하세요.
//     );
//   }
//
//   Widget _buildMenuItem({
//     required IconData icon,
//     required String text,
//     required VoidCallback onTap,
//   }) {
//     return Column(
//       children: [
//         InkWell(
//           onTap: onTap,
//           child: Container(
//             width: 400,
//             height: 100,
//             color: Colors.white10,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Icon(icon, size: 45, color: Colors.black),
//                 SizedBox(width: 20),
//                 Text(
//                   text,
//                   style: TextStyle(
//                     fontSize: 40,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Divider(thickness: 3, color: Colors.black),
//       ],
//     );
//   }
// }
//
//
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:project/Calender/calender.dart';
import 'package:project/Missing/Missing.dart';
import 'package:project/Quiz/QuizSelect.dart';
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
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildMenuItem(
              icon: Icons.calendar_month,
              text: "돌봄 다이어리",
              onTap: () => Get.to(() => CalenderApp()),
            ),
            _buildMenuItem(
              icon: Icons.grain,
              text: "데이케어 센터 검색",
              onTap: () async {
                try {
                  await NaverMapSdk.instance.initialize(
                    clientId: "ckwq0q1fl6",  // 자신의 네이버 API 키로 교체
                    onAuthFailed: (ex) {
                      debugPrint("********* 네이버맵 인증오류 : $ex *********");
                    },
                  );
                  Get.to(() => NMAP());
                } catch (e) {
                  debugPrint("NaverMap initialization error: $e");
                }
              },
            ),
            _buildMenuItem(
              icon: Icons.family_restroom,
              text: "우리 가족 퀴즈",
              onTap: () => Get.to(() => QuizSelect()),
            ),
            _buildMenuItem(
              icon: Icons.emoji_people,
              text: "어르신 길 잃음 방지",
              onTap: () => Get.to(() => Missing()),
            ),
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

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 400,
            height: 100,
            color: Colors.white10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon, size: 45, color: Colors.black),
                SizedBox(width: 20),
                Text(
                  text,
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
      ],
    );
  }
}

class NMAP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NaverMap(
      options: NaverMapViewOptions(
        indoorEnable: false,
        locationButtonEnable: true,
        scrollGesturesEnable: true,
        consumeSymbolTapEvents: true,
        initialCameraPosition: NCameraPosition(
          target: NLatLng(37.5666, 126.979),
          zoom: 10,
          bearing: 0,
          tilt: 0,
        ),
        mapType: NMapType.basic,
        activeLayerGroups: [NLayerGroup.building, NLayerGroup.transit],
      ),
      onMapReady: (Controller) {
        final marker = NMarker(
            id: 'test',
            position: NLatLng(37.506932467450326, 127.05578661133796));
        final marker1 = NMarker(
            id: 'test1',
            position: NLatLng(37.606932467450326, 127.05578661133796));
        final marker2 = NMarker(
            id: "test2",
            position: NLatLng(37.654580, 127.060594));
        final marker3 = NMarker(id: "test4", position: NLatLng(
            37.568337, 126.897679));
        Controller.addOverlayAll({marker, marker1,marker2,marker3});

        final OnMarkerInfoMap1 =
        NInfoWindow.onMarker(id: marker1.info.id, text: "test1");
        marker1.openInfoWindow(OnMarkerInfoMap1);
        final OnMarkerInfoMap12 =
        NInfoWindow.onMarker(id: marker2.info.id, text: "test3");
        marker2.openInfoWindow(OnMarkerInfoMap12);
        final OnMarkerInfoMap =
        NInfoWindow.onMarker(id: marker.info.id, text: "test2");
        marker.openInfoWindow(OnMarkerInfoMap);

        final OnMarkerInfoMap2 =
        NInfoWindow.onMarker(id: marker3.info.id, text: "test4");
        marker3.openInfoWindow(OnMarkerInfoMap2);

      },
      onMapTapped: (point, latLng) {
        debugPrint("${latLng.latitude}、${latLng.longitude}");
      },
    );
  }
}