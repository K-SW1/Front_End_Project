// import 'dart:async';
// import 'dart:developer' show log;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:project/Calender/calender.dart';
// import 'package:project/Main/Second.dart';
// import 'package:project/Quiz/QuizSelect.dart';
// import 'package:project/aasd/teste.dart';
// import 'package:project/components/custom_banner.dart';
// import 'package:project/components/custom_appbar.dart';
// import 'package:flutter_naver_map/flutter_naver_map.dart';
//
// import '../components/custom_textquiz_form.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MainHome());
// }
//
// // Uncomment and configure the Naver Map initialization if needed
// // Future<void> _initializeNaverMap() async {
// //   await NaverMapSdk.instance.initialize(
// //     clientId: 'ckwq0q1fl6',
// //     onAuthFailed: (ex) => log("********* 네이버맵 인증오류 : $ex *********"),
// //   );
// // }
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
//   Widget _buildMenuItem(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
//     return ListTile(
//       leading: Icon(icon, size: 40),
//       title: Text(label, style: TextStyle(fontSize: 20)),
//       onTap: onTap,
//     );
//   }
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
//             _buildMenuItem(
//               context,
//               icon: Icons.calendar_month,
//               label: "돌봄 다이어리",
//               onTap: () {
//                 Get.to(() => CalenderApp());
//               },
//             ),
//             Divider(thickness: 3, color: Colors.black),
//             _buildMenuItem(
//               context,
//               icon: Icons.grain,
//               label: "데이케어 센터 검색",
//               onTap: () {
//                 Get.to(() => CenterSearch());
//               },
//             ),
//             Divider(thickness: 3, color: Colors.black),
//             _buildMenuItem(
//               context,
//               icon: Icons.family_restroom,
//               label: "우리 가족 퀴즈",
//               onTap: () {
//                 Get.to(() => QuizSelect());
//               },
//             ),
//             Divider(thickness: 3, color: Colors.black),
//             _buildMenuItem(
//               context,
//               icon: Icons.emoji_people,
//               label: "어르신 길 잃음 방지",
//               onTap: () {
//                 Get.to(() => Second());
//               },
//             ),
//             Divider(thickness: 3, color: Colors.black),
//             SizedBox(height: 101),
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
//           BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 45), label: ""),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MemoApp',
      home: MyAppPage(),
    );
  }
}

// 기본 홈
class MyAppPage extends StatefulWidget {
  const MyAppPage({super.key});

  @override
  State<MyAppPage> createState() => MyAppState();
}

class MyAppState extends State<MyAppPage> {
  // 바텀 네비게이션 바 인덱스
  int _selectedIndex = 0;

  final List<Widget> _navIndex = [
    MyMemoPage(),
    CommunityPage(),
    MyInfoPage(),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navIndex.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue,
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home_filled),
          //   label: '홈',
          //   backgroundColor: Colors.white,
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books_outlined),
            label: '메모',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2),
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '내 정보',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
      ),
    );
  }
}

// 메모 페이지
// 앱의 상태를 변경해야하므로 StatefulWidget 상속
class MyMemoPage extends StatefulWidget {
  const MyMemoPage({super.key});

  @override
  MyMemoState createState() => MyMemoState();
}

class MyMemoState extends State<MyMemoPage> {
  // 검색어
  String searchText = '';

  // 리스트뷰에 표시할 내용
  final List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  final List<String> itemContents = [
    'Item 1 Contents',
    'Item 2 Contents',
    'Item 3 Contents',
    'Item 4 Contents'
  ];

  // 플로팅 액션 버튼을 이용하여 항목을 추가할 제목과 내용
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  // 리스트뷰 카드 클릭 이벤트
  void cardClickEvent(BuildContext context, int index) {
    String content = itemContents[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        // 정의한 ContentPage의 폼 호출
        builder: (context) => ContentPage(content: content),
      ),
    );
  }

  // 플로팅 액션 버튼 클릭 이벤트
  Future<void> addItemEvent(BuildContext context) {
    // 다이얼로그 폼 열기
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('항목 추가하기'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: '제목',
                ),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  labelText: '내용',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('추가'),
              onPressed: () {
                setState(() {
                  String title = titleController.text;
                  String content = contentController.text;
                  items.add(title);
                  itemContents.add(content);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bottom Navigation Bar Example'), // 앱 상단바 설정
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '검색어를 입력해주세요.',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              // items 변수에 저장되어 있는 모든 값 출력
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                // 검색 기능, 검색어가 있을 경우
                if (searchText.isNotEmpty &&
                    !items[index]
                        .toLowerCase()
                        .contains(searchText.toLowerCase())) {
                  return SizedBox.shrink();
                }
                // 검색어가 없을 경우, 모든 항목 표시
                else {
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.elliptical(20, 20))),
                    child: ListTile(
                      title: Text(items[index]),
                      onTap: () => cardClickEvent(context, index),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      // 플로팅 액션 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () => addItemEvent(context), // 버튼을 누를 경우
        tooltip: 'Add Item', // 플로팅 액션 버튼 설명
        child: Icon(Icons.add), // + 모양 아이콘
      ),
    );
  }
}

// 선택한 항목의 내용을 보여주는 추가 페이지
class ContentPage extends StatelessWidget {
  final String content;

  const ContentPage({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Content'),
      ),
      body: Center(
        child: Text(content),
      ),
    );
  }
}

// 커뮤니티 페이지
class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => CommunityState();
}

class CommunityState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'community page',
        ),
      ),
    );
  }
}

// 내 정보 페이지
class MyInfoPage extends StatelessWidget {
  const MyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'my info page',
        ),
      ),
    );
  }
}