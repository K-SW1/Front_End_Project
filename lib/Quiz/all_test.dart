import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/components/custom_appbar.dart';

class TextQuiz {
  final int textQuizId;
  final String question;
  final String hint;

  TextQuiz({required this.textQuizId, required this.question, required this.hint});

  factory TextQuiz.fromJson(Map<String, dynamic> json) {
    return TextQuiz(
      textQuizId: json['textQuizId'],
      question: json['question'],
      hint: json['hint'],
    );
  }
}

class Allquiz extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<Allquiz> {
  List<TextQuiz> quizList = [];

  @override
  void initState() {
    super.initState();
    fetchQuizzes();
  }

  Future<void> fetchQuizzes() async {
    String url = 'http://localhost:8080/textquiz/all';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    if (accessToken == null) {
      print('No access token found.');
      return;
    }

    Map<String, String> headers = {
      'accessToken': '$accessToken',
      'Content-Type': 'application/json',
    };

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        // 명시적으로 UTF-8로 디코딩 처리
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> responseData = jsonDecode(responseBody);
        print('Response Data: $responseData'); // Log the data

        setState(() {
          List<dynamic> dataJson = responseData['data'] ?? [];
          quizList = dataJson.map((quiz) => TextQuiz.fromJson(quiz)).toList();
        });

        print('퀴즈 데이터를 성공적으로 가져왔습니다.');
      } else {
        print('Failed to fetch quizzes. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred while fetching quizzes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: quizList.isNotEmpty
                ? ListView.builder(
              itemCount: quizList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizDetailPage(
                          textQuizId: quizList[index].textQuizId,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "퀴즈 : ${quizList[index].question}",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        // Text(
                        //   'Hint: ${quizList[index].hint}',
                        //   style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            )
                : Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}

class QuizDetailPage extends StatefulWidget {
  final int textQuizId;

  QuizDetailPage({required this.textQuizId});

  @override
  _QuizDetailPageState createState() => _QuizDetailPageState();
}

class _QuizDetailPageState extends State<QuizDetailPage> {
  late Future<QuizDetail> _quizDetail;
  String? selectedAnswer;
  String feedbackMessage = '';

  @override
  void initState() {
    super.initState();
    _quizDetail = fetchQuizDetail(widget.textQuizId);
  }

  Future<QuizDetail> fetchQuizDetail(int textQuizId) async {
    String url = 'http://localhost:8080/textquizDistractor/$textQuizId/details';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    if (accessToken == null) {
      throw Exception('No access token found.');
    }

    Map<String, String> headers = {
      'accessToken': '$accessToken',
      'Content-Type': 'application/json',
    };

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        // 명시적으로 UTF-8로 디코딩 처리
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> responseData = jsonDecode(responseBody);
        print('Response Data: $responseData'); // Log the data

        return QuizDetail.fromJson(responseData['data']);
      } else {
        throw Exception('Failed to fetch quiz detail. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception occurred while fetching quiz detail: $e');
    }
  }
  void checkAnswer() {
    if (selectedAnswer == null) {
      setState(() {
        feedbackMessage = 'Please select an answer.';
      });
      return;
    }

    _quizDetail.then((detail) {
      final distractorList = detail.distractors
          .where((d) => d.textzQuizDistractor == selectedAnswer)
          .toList();

      if (distractorList.isNotEmpty) {
        final selectedDistractor = distractorList.first;
        setState(() {
          feedbackMessage = selectedDistractor.validation ? '정답입니다!' : '틀렸습니다.\n다시 시도해보세요!';
        });
      } else {
        setState(() {
          feedbackMessage = '보기에서 정답을 선택해 주세요.';
        });
      }
    }).catchError((error) {
      setState(() {
        feedbackMessage = '오류 발생: ${error.toString()}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder<QuizDetail>(
        future: _quizDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          }

          final quizDetail = snapshot.data!;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
                children: [
                  Text(
                    '문제 : ${quizDetail.question}',
                    textAlign: TextAlign.center, // Center text alignment
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '힌트 : ${quizDetail.hint}',
                    textAlign: TextAlign.center, // Center text alignment
                    style: TextStyle(fontSize: 25, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '보기',
                    textAlign: TextAlign.center, // Center text alignment
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: quizDetail.distractors.map((distractor) {
                      return RadioListTile<String>(
                        title: Text(distractor.textzQuizDistractor),
                        value: distractor.textzQuizDistractor,
                        groupValue: selectedAnswer,
                        onChanged: (value) {
                          setState(() {
                            selectedAnswer = value;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: checkAnswer,
                    child: Text(
                      '제출하기',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    feedbackMessage,
                    textAlign: TextAlign.center, // Center text alignment
                    style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class QuizDetail {
  final int textQuizId;
  final String question;
  final String hint;
  final List<Distractor> distractors;

  QuizDetail({required this.textQuizId, required this.question, required this.hint, required this.distractors});

  factory QuizDetail.fromJson(Map<String, dynamic> json) {
    var distractorsJson = json['distractors'] as List? ?? [];
    List<Distractor> distractorsList = distractorsJson.map((d) => Distractor.fromJson(d)).toList();

    return QuizDetail(
      textQuizId: json['textQuizId'],
      question: json['question'],
      hint: json['hint'],
      distractors: distractorsList,
    );
  }
}

class Distractor {
  final String textzQuizDistractor;
  final bool validation;

  Distractor({required this.textzQuizDistractor, required this.validation});

  factory Distractor.fromJson(Map<String, dynamic> json) {
    return Distractor(
      textzQuizDistractor: json['textzQuizDistractor'] ?? '',
      validation: json['validation'] == true,
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Allquiz(),
  ));
}