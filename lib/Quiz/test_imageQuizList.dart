import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/components/custom_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ImageQuiz {
  final int imageQuizId;
  final String question;
  final String hint;

  ImageQuiz({required this.imageQuizId, required this.question, required this.hint});

  factory ImageQuiz.fromJson(Map<String, dynamic> json) {
    return ImageQuiz(
      imageQuizId: json['imageQuizId'],
      question: json['question'],
      hint: json['hint'],
    );
  }
}

class ImageQuizPage extends StatefulWidget {
  @override
  _ImageQuizPageState createState() => _ImageQuizPageState();
}

class _ImageQuizPageState extends State<ImageQuizPage> {
  List<ImageQuiz> quizList = [];

  @override
  void initState() {
    super.initState();
    fetchQuizzes();
  }

  Future<void> fetchQuizzes() async {
    String url = 'http://localhost:8080/imagequiz/all';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    if (accessToken == null) {
      print('토큰이 없습니다');
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accessToken': accessToken,
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> responseData = jsonDecode(responseBody);

        setState(() {
          quizList = (responseData['data'] ?? []).map<ImageQuiz>((quiz) => ImageQuiz.fromJson(quiz)).toList();
        });
      } else {
        print('Failed to fetch quizzes: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: quizList.isNotEmpty
          ? ListView.builder(
        itemCount: quizList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizDetailPage(
                    imageQuizId: quizList[index].imageQuizId,
                  ),
                ),
              );
            },
            child: QuizCard(quiz: quizList[index]),
          );
        },
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class QuizCard extends StatelessWidget {
  final ImageQuiz quiz;

  const QuizCard({required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quiz.question,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '힌트: ${quiz.hint}',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

// QuizDetail 페이지, imageQuizId를 통해 상세 정보를 가져와 화면에 표시
class QuizDetailPage extends StatefulWidget {
  final int imageQuizId;

  QuizDetailPage({required this.imageQuizId});

  @override
  _QuizDetailPageState createState() => _QuizDetailPageState();
}

class _QuizDetailPageState extends State<QuizDetailPage> {
  late Future<QuizDetail> _quizDetailFuture;
  String? selectedAnswer; // 사용자가 선택한 답변을 저장할 변수
  String feedbackMessage = ''; // 피드백 메시지를 저장할 변수

  @override
  void initState() {
    super.initState();
    _quizDetailFuture = fetchQuizDetail(widget.imageQuizId);
  }

  Future<QuizDetail> fetchQuizDetail(int imageQuizId) async {
    // 실제 서버 API 호출 부분
    // 아래의 코드에서 imageUrl은 API로부터 가져온 경로로 교체됩니다.
    String imageUrl = "/images/c4ce0c18-5e88-4926-9f2e-b256a5d5ee0a.jpg";

    // 로컬 파일 경로로 변환
    final directory = "/Users/parkhw/Desktop/imageFile";
    String localPath = "$directory/$imageUrl".replaceAll("/images/", "");

    // 실제로는 API 응답으로 데이터를 받아야 하며, 예시를 위해 하드코딩된 데이터를 반환합니다.
    return QuizDetail(
      question: "FlutterTestImage",
      hint: "test",
      imageUrl: localPath,
      distractors: [
        Distractor(imageQuizDistractor: "Test1", validation: false),
        Distractor(imageQuizDistractor: "Test2", validation: false),
        Distractor(imageQuizDistractor: "Test3", validation: true),
      ],
    );
  }

  void checkAnswer() {
    if (selectedAnswer == null) {
      setState(() {
        feedbackMessage = '답변을 선택해 주세요.';
      });
      return;
    }
    _quizDetailFuture.then((detail) {
      final distractorList = detail.distractors
          .where((d) => d.imageQuizDistractor == selectedAnswer)
          .toList();
      if (distractorList.isNotEmpty) {
        final selectedDistractor = distractorList.first;
        setState(() {
          feedbackMessage = selectedDistractor.validation ? '정답입니다!' : '틀렸습니다.';
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
        future: _quizDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('데이터 없음'));
          }

          final quizDetail = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('문제: ${quizDetail.question}',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text('힌트: ${quizDetail.hint}',
                  style: TextStyle(fontSize: 25, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                // 이미지 표시
                quizDetail.imageUrl != null
                    ? Image.file(
                  File(quizDetail.imageUrl!),
                  height: 200,
                )
                    : Container(),
                SizedBox(height: 16),
                // 퀴즈 질문 및 힌트 표시
                // 보기 목록 표시
                Text('보기:',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                ...quizDetail.distractors.map((distractor) {
                  return Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            distractor.imageQuizDistractor,
                            style: TextStyle(fontSize: 16),
                          ),
                          leading: Radio<String>(
                            value: distractor.imageQuizDistractor,
                            groupValue: selectedAnswer,
                            onChanged: (String? value) {
                              setState(() {
                                selectedAnswer = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
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
                  style: TextStyle(fontSize: 18, color: Colors.red),
                  textAlign: TextAlign.center, // 텍스트 가운데 정렬
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     checkAnswer();
                //     showDialog(
                //       context: context,
                //       builder: (context) {
                //         return AlertDialog(
                //           title: Text(feedbackMessage),
                //           actions: [
                //             TextButton(
                //               child: Text('확인'),
                //               onPressed: () {
                //                 Navigator.of(context).pop();
                //               },
                //             ),
                //           ],
                //         );
                //       },
                //     );
                //   },
                //   child: Text('답안 제출'),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class QuizDetail {
  final String question;
  final String hint;
  final String? imageUrl;
  final List<Distractor> distractors;

  QuizDetail({
    required this.question,
    required this.hint,
    this.imageUrl,
    required this.distractors,
  });
}

class Distractor {
  final String imageQuizDistractor;
  final bool validation;

  Distractor({
    required this.imageQuizDistractor,
    required this.validation,
  });
}
