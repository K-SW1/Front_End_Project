import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Calender/calender.dart';
import 'package:project/Quiz/TextQuiz.dart';
import 'package:project/Main/MainHome.dart';

class CustomBottom extends StatefulWidget {
  @override
  State<CustomBottom> createState() => CustomBottomState();
}

class CustomBottomState extends State<CustomBottom> {
  Color appBarColor = Color.fromRGBO(121, 159, 165, 1.0);
  int _selectedIndex = 0;

  final List<Widget> _navIndex = [
    Home(),
    CalenderApp(),
    TextQuiz(),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Get.to(() => CalenderApp());
          break;
        case 1:
          Get.to(() => Home());
          break;
        case 2:
          Get.to(() => TextQuiz());
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onNavTapped,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      selectedItemColor: appBarColor,
      unselectedItemColor: appBarColor,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.phone,size: 45), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.home,size: 45), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle,size: 45), label: ""),
      ],
    );
  }
}
