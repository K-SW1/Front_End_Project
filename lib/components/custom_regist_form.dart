import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Login/LoginPage.dart';


class MemberRegistrationPage extends StatefulWidget {
  @override
  _MemberRegistrationPageState createState() => _MemberRegistrationPageState();
}

class _MemberRegistrationPageState extends State<MemberRegistrationPage> {
  TextEditingController loginIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<void> registerMember() async {
    String url = 'http://localhost:8080/members/join'; // 에뮬레이터에서 사용할 URL, 실제 서버 IP로 변경 필요

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'userLoginId': loginIdController.text,
      'userLoginPassword': passwordController.text,
      'name': nameController.text,
      'phoneNumber': phoneNumberController.text,
      'mail': emailController.text,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('회원가입 성공');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "회원가입 성공!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Color.fromRGBO(121, 159, 161, 1.0),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        print('회원가입 실패: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "회원가입 실패!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Color.fromRGBO(121, 159, 161, 1.0),
          ),
        );
      }
    } catch (e) {
      print('회원가입 실패: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "회원가입 중 오류 발생: $e",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(121, 159, 161, 1.0),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image(
                image: AssetImage('assets/images/recall_splash.png'),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 100),
            TextField(
              controller: loginIdController,
              decoration: InputDecoration(labelText: 'ID를 입력하세요.'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: '비밀번호를 입력하세요.'),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: '이름을 입력하세요.'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: '휴대폰번호를 입력하세요.'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email을 입력하세요.'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Color.fromRGBO(121, 159, 161, 1.0),
                elevation: 0,
              ),
              onPressed: registerMember,
              child: Text(
                '회 원 가 입',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
