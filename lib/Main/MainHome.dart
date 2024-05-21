// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:project/Main/Second.dart';
// import 'package:project/Main/first.dart';
// import 'package:project/components/custom_leading_button.dart';
//
// void main() => runApp(MainHome());
//
// class MainHome extends StatefulWidget {
//   const MainHome({super.key});
//
//   @override
//   State<MainHome> createState() => _MainHomeState();
// }
//
// class _MainHomeState extends State<MainHome> {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: home(),
//     );
//   }
// }
//
// class home extends StatelessWidget {
//   const home({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         actions: [
//           IconButton(onPressed: () {
//             Get.to(() => first());
//           },
//               icon: Icon(Icons.notifications_active_outlined,size: 30,))
//         ],
//           backgroundColor: Colors.lightBlue,
//           iconTheme: IconThemeData(color: Colors.white),
//           title: Text("",style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),)),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               width: 300,
//               height: 100,
//               color: Colors.white10,
//               child: Center(
//                 child: Text(
//                   "1",style: TextStyle(fontSize: 30),
//                 ),
//               ),
//
//             ),
//             Divider(thickness: 3,color: Colors.black,),
//             Container(
//               width: 300,
//               height: 100,
//               color: Colors.white10,
//               child: Center(
//                 child: Text(
//                   "2",style: TextStyle(fontSize: 30),
//                 ),
//               ),
//             ),
//             Divider(thickness: 3,color: Colors.black,),
//             Container(
//               width: 300,
//               height: 100,
//               color: Colors.white10,
//               child: Center(
//                 child: Text(
//                   "3",style: TextStyle(fontSize: 30),
//                 ),
//               ),
//             ),
//             Divider(thickness: 3,color: Colors.black,),
//             Container(
//               width: 300,
//               height: 100,
//               color: Colors.white10,
//               child: Center(
//                 child: Text(
//                   "4",style: TextStyle(fontSize: 30),
//                 ),
//               ),
//             ),
//             Divider(thickness: 3,color: Colors.black,),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.lightBlue,
//         unselectedItemColor: Colors.grey,
//         selectedLabelStyle: TextStyle(
//           fontWeight: FontWeight.bold
//         ),
//         unselectedLabelStyle: TextStyle(
//           fontWeight: FontWeight.bold
//         ),
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.phone,size: 35,),
//             label: ""
//           ),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.home,size: 35,),
//             label: "",
//           ),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.account_circle,size: 35,),
//             label: "",
//           )
//         ],
//       )
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Main/Second.dart';
import 'package:project/Main/first.dart';
import 'package:project/components/custom_banner.dart';


void main() => runApp(MainHome());

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Color appBarColor = Color.fromRGBO(121,159,165,1.0);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        // backgroundColor: Colors.lightBlue,
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Image(
              image: AssetImage("assets/images/recall_splash.png"),
              fit: BoxFit.contain,
              height: 40, // 이미지의 높이 조절
            ),
            SizedBox(width: 104), // 아이콘과 이미지 사이의 간격 조절
            IconButton(
              onPressed: () {
                Get.to(() => first());
              },
              icon: Icon(Icons.notifications_active_outlined, size: 40),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [


            InkWell(
              onTap: () {
                Get.to(()=> Second());
              },
              child: Container(
                width: 400,
                height: 100,
                color: Colors.white10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 45,
                      color: Colors.black,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "치매 자가 체크리스트",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),

            Divider(thickness: 3, color: Colors.black),

            Container(
              width: 400,
              height: 100,
              color: Colors.white10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.grain,
                    size: 40, // 아이콘 크기를 줄임
                    color: Colors.black,
                  ),
                  SizedBox(width: 20),
                  Text(
                    "뇌 건강 트레이닝",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold), // 텍스트 크기를 줄임
                  ),
                ],
              ),
            ),

            Divider(thickness: 3, color: Colors.black),


            InkWell(
              onTap: (){
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
                      Icons.family_restroom,
                      size: 40,
                      color: Colors.black,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "우리 가족 퀴즈",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),

            Divider(thickness: 3, color: Colors.black),


            InkWell(
              onTap: () {
                Get.to(()=> Second());
              },
              child: Container(
                width: 400,
                height: 100,
                color: Colors.white10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.calendar_month,
                    size: 40,
                    color: Colors.black
                    ),
                    SizedBox(width: 20),
                    Text(
                      "돌봄 다이어리",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),

            Divider(thickness: 3, color: Colors.black),

            Text("\n\n\n\n\n"),

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
          BottomNavigationBarItem(icon: Icon(Icons.phone, size: 35), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 35), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 35), label: ""),
        ],
      ),
    );
  }
}
