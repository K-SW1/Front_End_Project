import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Login/LoginMain.dart';
import 'package:project/Login/LoginPage.dart';
import 'package:project/components/custom_appbar.dart';

void main() => runApp(DementiaTest());

class DementiaTest extends StatelessWidget {
  final List<String> questions = [
    "질문 1 \n오늘이 몇 월이고,무슨 요일인지를 잘 모른다",
    "질문 2 \n자기가 놔둔 물건을 찾지 못한다",
    "질문 3 \n같은 질문을 반복해서 한다",
    "질문 4 \n약속을 하고서 잊어버린다.",
    "질문 5 \n물건을 가지러 갔다가 잊어버리고 그냥 온다.",
    "질문 6 \n물건이나, 사람의 이름을 대기가 힘들어 머뭇거린다.",
    "질문 7 \n대화 중 내용이 이해되지 않아 반복해서 물어본다.",
    "질문 8 \n길을 잃거나 헤맨 적이 있다.",
    "질문 9 \n예전에 비해서 계산능력이 떨어졌다.",
    "질문 10 \n예전에 비해 성격이 변했다.",
    "질문 11 \n이전에 잘 다루던 기구의 사용이 서툴러졌다.",
    "질문 12 \n예전에 비해 방이나 집안의 정리 정돈을 하지 못한다.",
    "질문 13 \n상황에 맞게 스스로 옷을 선택하여 입지 못한다",
    "질문 14 \n혼자 대중교통 수단을 이용하여 목적지에 가기 힘들다.",
    "질문 15 \n내복이나 옷이 더러워져도 갈아입지 않으려고 한다.",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "치매 자가 체크리스트",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: QuestionPageView(questions: questions),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionPageView extends StatefulWidget {
  final List<String> questions;

  QuestionPageView({required this.questions});

  @override
  _QuestionPageViewState createState() => _QuestionPageViewState();
}

class _QuestionPageViewState extends State<QuestionPageView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  int _totalScore = 0;

  void _nextPage() {
    if (_currentIndex < widget.questions.length) {
      setState(() {
        _currentIndex++;
        _pageController.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void _prevPage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _pageController.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void _updateScore(int score) {
    setState(() {
      _totalScore += score;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.questions.length + 1,
            itemBuilder: (context, index) {
              if (index == widget.questions.length) {
                return ResultWidget(totalScore: _totalScore);
              } else {
                return QuestionWidget(
                  question: widget.questions[index],
                  onNext: _nextPage,
                  onPrevious: _prevPage,
                  onScoreSelected: _updateScore,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class QuestionWidget extends StatefulWidget {
  final String question;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final ValueChanged<int> onScoreSelected;

  QuestionWidget({
    required this.question,
    required this.onNext,
    required this.onPrevious,
    required this.onScoreSelected,
  });

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int? _answer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              widget.question,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          RadioListTile<int>(
            title: Text('그렇다'),
            value: 2,
            groupValue: _answer,
            onChanged: (value) {
              setState(() {
                _answer = value;
                if (value != null) {
                  widget.onScoreSelected(value);
                }
              });
            },
          ),
          RadioListTile<int>(
            title: Text('가끔 그렇다'),
            value: 1,
            groupValue: _answer,
            onChanged: (value) {
              setState(() {
                _answer = value;
                if (value != null) {
                  widget.onScoreSelected(value);
                }
              });
            },
          ),
          RadioListTile<int>(
            title: Text('아니다'),
            value: 0,
            groupValue: _answer,
            onChanged: (value) {
              setState(() {
                _answer = value;
              });
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: widget.onPrevious,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 둥근 모서리 설정
                    ),
                  ),
                  child: Text(
                    '이전',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5), // 버튼 사이의 간격
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: _answer != null ? widget.onNext : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 둥근 모서리 설정
                    ),
                  ),
                  child: Text(
                    '다음',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ResultWidget extends StatelessWidget {
  final int totalScore;

  ResultWidget({required this.totalScore});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              totalScore >= 6
                  ? '치매 위험이 있습니다. \n전문가와 상담하십시오.'
                  : '치매 위험이 낮습니다. \n계속해서 건강을 유지하세요.',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 첫 페이지로 이동
                Get.to(() => Login());
                // Navigator.of(context).pop();
              },
              child: Text(
                '처음으로 돌아가기',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
