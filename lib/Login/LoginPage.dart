import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Main/MainHome.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    String url = 'http://localhost:8080/auth/login';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'username': usernameController.text,
      'password': passwordController.text,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print('Login successful');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('로그인 성공!',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            backgroundColor: Color.fromRGBO(121,159,165,1.0),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainHome()),
        );  // Navigate to MainHome
      } else if (response.statusCode == 401) {
        // Unauthorized - wrong username or password
        print('Invalid username or password');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('잘못된 입력입니다!'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        print('Failed to login. Status code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ID/PW를 다시 입력하세요',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            backgroundColor: Color.fromRGBO(121,159,161,1.0),
          ),
        );
      }
    } catch (e) {
      print('Exception occurred while logging in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('로그인 실패!'),
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
        padding: const EdgeInsets.all(16.0),
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
              controller: usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100003,50),
                backgroundColor: Color.fromRGBO(121,159,161,1.0),
                elevation: 0
              ),
              onPressed: login,
              child: Text(
                '로   그   인',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}
