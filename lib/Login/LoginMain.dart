import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Login/LoginPage.dart';

void main() => runApp(LoginMain());

class LoginMain extends StatelessWidget {
  const LoginMain({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.black,
            primary: Color.fromRGBO(121,159,165,1.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            minimumSize: Size(400,60),
          )
        )
      ),
      initialRoute: "/login",
      routes: {
        "/login":(context) => LoginPage(),
      },
    );
  }
}
