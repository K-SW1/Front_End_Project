import 'package:flutter/material.dart';

import 'package:project/Regist/RegistPage.dart';
import 'package:project/components/custom_regist_form.dart';

void main() => runApp(RegistMain());

class RegistMain extends StatelessWidget {
  const RegistMain({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(400,60),
              )
          )
      ),
      initialRoute: "/regist",
      routes: {
        "/regist":(context) => MemberRegistrationPage(),
      },
    );
  }
}
