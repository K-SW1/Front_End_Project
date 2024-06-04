// import 'package:flutter/material.dart';
// import 'package:project/components/custom_appbar.dart';
// import 'package:project/components/custom_banner.dart';
// import 'package:project/components/custom_textquiz_answer.dart';
// import 'package:project/components/custom_textquiz_form.dart';
//
// void main() => runApp(TextQuiz());
//
// class TextQuiz extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Color appBarColor = Color.fromRGBO(121, 159, 165, 1.0);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               children: [
//                 SizedBox(height: 20),
//                 Text(
//                   "우리 가족 퀴즈 문제 등록",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 25,
//                   ),
//                 ),
//                 SizedBox(height: 50),
//                 Text(
//                   "문제 내용",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 CustomTextForm(),
//                 SizedBox(height: 53),
//                 Text(
//                   "힌트 내용",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 CustomTextForm(),
//                 SizedBox(height: 46),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Column(
//                       children: [
//                         Text(
//                           "보기 1",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         CustomTextAnswer(),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Text(
//                           "보기 2",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         CustomTextAnswer(),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Text(
//                           "보기 3",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         CustomTextAnswer(),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Text(
//                           "정답",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Color.fromRGBO(121, 159, 165, 1.0),
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         CustomTextAnswer(),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 39),
//                 ElevatedButton(
//                   onPressed: () {
//                     // 저장 로직을 여기에 추가
//                   },
//                   style: ElevatedButton.styleFrom(
//                     elevation: 0,
//                     primary: Colors.white,
//                   ),
//                   child: Text(
//                     '저장하기',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 0),
//                 Container(
//                   height: 140,
//                   child: CustomBanner(),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//
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





import 'package:flutter/material.dart';
import 'package:project/components/custom_appbar.dart';
import 'package:project/components/custom_banner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(TextQuiz());

class TextQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizForm(),
    );
  }
}

class QuizForm extends StatefulWidget {
  @override
  _QuizFormState createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _hintController = TextEditingController();
  final _answer1Controller = TextEditingController();
  final _answer2Controller = TextEditingController();
  final _answer3Controller = TextEditingController();
  final _correctAnswerController = TextEditingController();

  Color appBarColor = Color.fromRGBO(121, 159, 165, 1.0);

  @override
  void dispose() {
    _questionController.dispose();
    _hintController.dispose();
    _answer1Controller.dispose();
    _answer2Controller.dispose();
    _answer3Controller.dispose();
    _correctAnswerController.dispose();
    super.dispose();
  }

  Future<void> _saveQuiz() async {
    if (_formKey.currentState?.validate() ?? false) {
      final quizData = {
        'question': _questionController.text,
        'hint': _hintController.text,
        'answer1': _answer1Controller.text,
        'answer2': _answer2Controller.text,
        'answer3': _answer3Controller.text,
        'correctAnswer': _correctAnswerController.text,
      };

      print('Sending data to server: $quizData'); // 디버그 로그

      try {
        final response = await http.post(
          Uri.parse('http://localhost:8080/imagequiz/save'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(quizData),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('퀴즈가 성공적으로 저장되었습니다!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('퀴즈 저장에 실패했습니다: ${response.statusCode}')),
          );
          print('Failed to save quiz: ${response.statusCode} - ${response.body}'); // 디버그 로그
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('퀴즈 저장 중 오류가 발생했습니다: $error')),
        );
        print('Error occurred while saving quiz: $error'); // 디버그 로그
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "우리 가족 퀴즈 문제 등록",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "문제 내용",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomTextForm(controller: _questionController),
                    SizedBox(height: 20),
                    Text(
                      "힌트 내용",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomTextForm(controller: _hintController),
                    SizedBox(height: 20),
                    Text(
                      "보기 및 정답",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomTextAnswer(controller: _answer1Controller, label: "보기 1"),
                    CustomTextAnswer(controller: _answer2Controller, label: "보기 2"),
                    CustomTextAnswer(controller: _answer3Controller, label: "보기 3"),
                    CustomTextAnswer(controller: _correctAnswerController, label: "정답", color: appBarColor),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: _saveQuiz,
                        child: Text('저장하기'),
                      ),
                    ),
                    SizedBox(height: 90),
                    Container(
                      width: double.infinity,
                      height: 140,
                      child: CustomBanner(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: appBarColor,
        unselectedItemColor: appBarColor,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.phone, size: 45), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 45), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 45), label: ""),
        ],
      ),
    );
  }
}

class CustomTextForm extends StatelessWidget {
  final TextEditingController controller;

  CustomTextForm({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Full width
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding for better spacing
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '텍스트를 입력해주세요';
          }
          return null;
        },
      ),
    );
  }
}

class CustomTextAnswer extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Color? color;

  CustomTextAnswer({required this.controller, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color ?? Colors.black,
            ),
          ),
          Container(
            width: double.infinity, // Full width
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding for better spacing
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '텍스트를 입력해주세요';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
