// import 'dart:async';
// import 'dart:developer' show log;
// import 'package:flutter/material.dart';
// import 'package:flutter_naver_map/flutter_naver_map.dart';
// import 'package:project/components/custom_appbar.dart';
// import 'package:project/components/custom_textquiz_form.dart';
//
// void main() => runApp(CenterSearch1());
//
// class CenterSearch1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CenterSearchPage(),
//     );
//   }
// }
//
// class CenterSearchPage extends StatefulWidget {
//   @override
//   State<CenterSearchPage> createState() => _CenterSearchPageState();
// }
//
// class _CenterSearchPageState extends State<CenterSearchPage> {
//   late NaverMapController _mapController;
//   final Completer<NaverMapController> mapControllerCompleter = Completer();
//   final TextEditingController _searchController = TextEditingController();
//   NLatLng _searchedLocation = NLatLng(37.5666102, 126.9783881); // 초기 카메라 위치
//
//   @override
//   void initState() {
//     super.initState();
//     _initialize(); // SDK 초기화 호출
//   }
//
//   Future<void> _initialize() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await NaverMapSdk.instance.initialize(
//       clientId: 'ckwq0q1fl6',
//       onAuthFailed: (ex) => log("********* 네이버맵 인증오류 : $ex *********"),
//     );
//   }
//
//   Future<void> _searchLocation(String query) async {
//     // 여기에 네이버 API 검색 로직을 넣어 검색 위치를 받아옵니다.
//     // 예시로 고정된 좌표를 사용하고 있습니다.
//     if (query.toLowerCase() == "노원역") {
//       setState(() {
//         _searchedLocation = NLatLng(37.6252, 127.0721); // 노원역 좌표
//       });
//     } else {
//       log("검색 결과가 없습니다.");
//     }
//   }
//
//
//   Future<void> _moveCameraToSearchedLocation() async {
//     final controller = await mapControllerCompleter.future;
//
//     // 카메라 위치 이동을 위한 animateCamera 메서드 사용
//     await controller.animateCamera(
//       CameraUpdate.scrollTo(
//         _searchedLocation,  // 이동할 위치 (NLatLng)
//       ),
//     );
//     await controller.animateCamera(
//       CameraUpdate.zoomTo(14), // 줌 레벨 설정
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final pixelRatio = mediaQuery.devicePixelRatio;
//     final mapSize = Size(mediaQuery.size.width - 10, mediaQuery.size.height / 2);
//     final physicalSize = Size(mapSize.width * pixelRatio, mapSize.height * pixelRatio);
//
//     print("physicalSize: $physicalSize");
//
//     return Scaffold(
//       appBar: CustomAppBar(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               children: [
//                 SizedBox(height: 20),
//                 Text(
//                   "데이케어 센터 검색",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 _buildSearchForm(),
//                 SizedBox(height: 20),
//                 SizedBox(
//                   width: mapSize.width,
//                   height: mapSize.height,
//                   child: _naverMapSection(),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSearchForm() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextFormField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: "위치 검색",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           SizedBox(width: 10),
//           ElevatedButton(
//             onPressed: () {
//               _searchLocation(_searchController.text);
//             },
//             child: Text("검색"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _naverMapSection() => NaverMap(
//     options: const NaverMapViewOptions(
//       indoorEnable: true,
//       locationButtonEnable: false,
//       consumeSymbolTapEvents: false,
//     ),
//     onMapReady: (controller) async {
//       _mapController = controller;
//       mapControllerCompleter.complete(controller);
//       log("onMapReady", name: "onMapReady");
//
//       // 지도를 초기 위치로 이동
//
//     },
//   );
// }
//
//
//
//


import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
    clientId: "ckwq0q1fl6",
    onAuthFailed: (ex) {
      debugPrint("********* 네이버맵 인증오류 : $ex *********");
    },
  );

  runApp(
    NMAP(),
  );
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