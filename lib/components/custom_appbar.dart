import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Main/first.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    Color appbarColor = Color.fromRGBO(121, 159, 165, 1.0);
    return AppBar(
      elevation: 0,
      backgroundColor: appbarColor,
      automaticallyImplyLeading: false, // 뒤로가기 버튼을 숨김
      title: Row(
        children: [
          Image(
            image: AssetImage("assets/images/recall_splash.png"),
            fit: BoxFit.contain,
            height: 40,
          ),
          SizedBox(width: 104,),
          IconButton(
            onPressed: () {
              Get.to(() => first());
            },
            icon: Icon(Icons.notifications_active_outlined, size: 40),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
