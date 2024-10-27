import 'package:flutter/material.dart';
import 'package:project/components/custom_appbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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

  // State variables for storing validation values
  bool? _validation1;
  bool? _validation2;
  bool? _validation3;

  Color appBarColor = Color.fromRGBO(121, 159, 165, 1.0);
  int? _textQuizId;

  @override
  void dispose() {
    _questionController.dispose();
    _hintController.dispose();
    _answer1Controller.dispose();
    _answer2Controller.dispose();
    _answer3Controller.dispose();
    super.dispose();
  }

  Future<String?> _getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<String?> _getUserLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userLoginId');
  }

  Future<void> _saveQuestionAndHint() async {
    if (_formKey.currentState?.validate() ?? false) {
      String? accessToken = await _getAccessToken();
      String? userLoginId = await _getUserLoginId();

      final quizData = {
        'userLoginId': userLoginId,
        'question': _questionController.text,
        'hint': _hintController.text,
      };

      try {
        final response = await http.post(
          Uri.parse('http://localhost:8080/textquiz/add'),
          headers: {
            'Content-Type': 'application/json',
            'accessToken': '$accessToken',
          },
          body: jsonEncode(quizData),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          setState(() {
            _textQuizId = responseData['data']['textQuizId'];
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('문제와 힌트가 성공적으로 저장되었습니다!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('문제와 힌트 저장에 실패했습니다: ${response.statusCode}')),
          );
        }
      }
      catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('문제와 힌트 저장 중 오류가 발생했습니다: $error')),
        );
      }
    }
  }

  Future<void> _saveAnswersAndCorrectAnswer() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_textQuizId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('먼저 문제와 힌트를 저장해 주세요.')),
        );
        return;
      }

      String? accessToken = await _getAccessToken();
      if (accessToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('로그인 정보가 없습니다. 다시 로그인 해주세요.')),
        );
        return;
      }

      final distractors = [
        {
          'textQuizId': _textQuizId,
          'textzQuizDistractor': _answer1Controller.text,
          'validation': _validation1 ?? false,
        },
        {
          'textQuizId': _textQuizId,
          'textzQuizDistractor': _answer2Controller.text,
          'validation': _validation2 ?? false,
        },
        {
          'textQuizId': _textQuizId,
          'textzQuizDistractor': _answer3Controller.text,
          'validation': _validation3 ?? false,
        },
      ];

      try {
        for (var distractor in distractors) {
          final response = await http.post(
            Uri.parse('http://localhost:8080/textquizDistractor/$_textQuizId/distractor/add'),
            headers: {
              'Content-Type': 'application/json',
              'accessToken': '$accessToken',
            },
            body: jsonEncode(distractor),
          );

          if (response.statusCode != 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('보기와 정답 저장에 실패했습니다: ${response.statusCode}')),
            );
            return;
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('보기와 정답이 성공적으로 저장되었습니다!')),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('보기와 정답 저장 중 오류가 발생했습니다: $error')),
        );
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
                    Center(
                      child: ElevatedButton(
                        onPressed: _saveQuestionAndHint,
                        child: Text(
                          '문제와 힌트 저장',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "보기 및 정답",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomTextAnswer(
                      controller: _answer1Controller,
                      label: "보기 1",
                      onValidationChanged: (value) {
                        setState(() {
                          _validation1 = value;
                        });
                      },
                    ),
                    CustomTextAnswer(
                      controller: _answer2Controller,
                      label: "보기 2",
                      onValidationChanged: (value) {
                        setState(() {
                          _validation2 = value;
                        });
                      },
                    ),
                    CustomTextAnswer(
                      controller: _answer3Controller,
                      label: "보기 3",
                      onValidationChanged: (value) {
                        setState(() {
                          _validation3 = value;
                        });
                      },
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: _saveAnswersAndCorrectAnswer,
                        child: Text(
                          '보기와 정답 저장',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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


class CustomTextAnswer extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Function(bool) onValidationChanged;

  CustomTextAnswer({
    required this.controller,
    required this.label,
    required this.onValidationChanged,
  });

  @override
  _CustomTextAnswerState createState() => _CustomTextAnswerState();
}

class _CustomTextAnswerState extends State<CustomTextAnswer> {
  bool _isCorrect = false; // Internal state to track the correct answer

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: widget.controller,
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
          SizedBox(height: 10),
          Row(
            children: [
              Text("정답 여부:"),
              SizedBox(width: 10),
              ChoiceChip(
                label: Text('정답'),
                selected: _isCorrect,
                onSelected: (selected) {
                  setState(() {
                    _isCorrect = selected;
                    widget.onValidationChanged(_isCorrect); // Notify parent widget
                  });
                },
              ),
              SizedBox(width: 10),
              ChoiceChip(
                label: Text('거짓'),
                selected: !_isCorrect,
                onSelected: (selected) {
                  setState(() {
                    _isCorrect = !selected;
                    widget.onValidationChanged(_isCorrect); // Notify parent widget
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}