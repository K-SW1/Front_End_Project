// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:project/Main/MainHome.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Login extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<Login> {
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   Future<void> login() async {
//     String url = 'http://localhost:8080/auth/login'; // 로그인 요청 URL
//
//     Map<String, String> headers = {
//       'Content-Type': 'application/json',
//     };
//
//     Map<String, dynamic> body = {
//       'username': usernameController.text,
//       'password': passwordController.text,
//     };
//
//     try {
//       var response = await http.post(
//         Uri.parse(url),
//         headers: headers,
//         body: jsonEncode(body),
//       );
//
//       if (response.statusCode == 200) {
//         var responseData = jsonDecode(response.body);
//         String accessToken = responseData['accessToken'];
//         String refreshToken = responseData['refreshToken'];
//
//         // 로그인 성공 시 SharedPreferences에 accessToken 및 username 저장
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.setString('accessToken', accessToken);
//         prefs.setString('username', usernameController.text);
//
//         print('로그인 성공');
//         print('accessToken: $accessToken');
//         print('refreshToken: $refreshToken');
//         print("\n");
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('로그인 성공!', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
//             backgroundColor: Color.fromRGBO(121, 159, 165, 1.0),
//           ),
//         );
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => MainHome()),
//         );
//       } else if (response.statusCode == 401) {
//         print('ID/PW를 다시 입력하세요');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('ID/PW를 다시 입력하세요', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
//             backgroundColor: Color.fromRGBO(121, 159, 161, 1.0),
//           ),
//         );
//       } else {
//         print('Failed to login. Status code: ${response.statusCode}');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('로그인 실패', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//             backgroundColor: Color.fromRGBO(121, 159, 161, 1.0),
//           ),
//         );
//       }
//     } catch (e) {
//       print('Exception occurred while logging in: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('로그인 실패!'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(121, 159, 161, 1.0),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Image(
//                 image: AssetImage('assets/images/recall_splash.png'),
//                 fit: BoxFit.contain,
//               ),
//             ),
//             SizedBox(height: 100),
//             TextField(
//               controller: usernameController,
//               decoration: InputDecoration(labelText: "ID"),
//             ),
//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: InputDecoration(labelText: 'Password'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 minimumSize: Size(double.infinity, 50),
//                 backgroundColor: Color.fromRGBO(121, 159, 161, 1.0),
//                 elevation: 0,
//               ),
//               onPressed: login,
//               child: Text(
//                 '로   그   인',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Login(),
//   ));
// }
//

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Main/MainHome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    String url = 'http://localhost:8080/auth/login'; // 로그인 요청 URL

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
        var responseData = jsonDecode(response.body);
        String accessToken = responseData['accessToken'];
        String refreshToken = responseData['refreshToken'];

        // 로그인 성공 시 SharedPreferences에 accessToken 및 username 저장
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('accessToken', accessToken);
        prefs.setString('username', usernameController.text);

        print('로그인 성공');
        print('accessToken: $accessToken');
        print('refreshToken: $refreshToken');
        print("\n");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('로그인 성공!', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            backgroundColor: Color.fromRGBO(121, 159, 165, 1.0),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainHome()),
        );
      } else if (response.statusCode == 401) {
        print('ID/PW를 다시 입력하세요');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ID/PW를 다시 입력하세요', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            backgroundColor: Color.fromRGBO(121, 159, 161, 1.0),
          ),
        );
      } else {
        print('Failed to login. Status code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('로그인 실패', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            backgroundColor: Color.fromRGBO(121, 159, 161, 1.0),
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
              decoration: InputDecoration(labelText: "ID"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Color.fromRGBO(121, 159, 161, 1.0),
                elevation: 0,
              ),
              onPressed: login,
              child: Text(
                '로   그   인',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
    home: Login(),
  ));
}
