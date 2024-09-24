/**
 *
 * // 등록된 메모 가져오기부터 수정하면 댐

 */
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/components/custom_appbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AddNoteScreen extends StatefulWidget {
  final DateTime selectedDay;

  AddNoteScreen({required this.selectedDay});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController _patientController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TextEditingController _hourController = TextEditingController();
  TextEditingController _minuteController = TextEditingController();

  List<Map<String, dynamic>> _diaryEntries = []; // 메모 데이터를 담는 리스트

  // SharedPreferences에서 accessToken 가져오기
  Future<String?> _getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  // 서버로 메모 저장 요청 보내기
  Future<void> _saveDiary() async {
    String? accessToken = await _getAccessToken();

    if (accessToken == null) {
      print("토큰이 없습니다.");
      return;
    }

    final diary = {
      "name": _patientController.text,
      "time": "${_hourController.text}:${_minuteController.text}",
      "memo": _noteController.text,
      "date": DateFormat('yyyyMMdd').format(widget.selectedDay), // yyyyMMdd 형식으로 날짜 변환
    };

    try {
      final response = await http.post(
        Uri.parse("http://localhost:8080/diary/add"),
        headers: {
          "Content-type": "application/json",
          "accessToken": accessToken,
        },
        body: jsonEncode(diary),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("성공적으로 저장되었습니다!")),
        );
        _fetchDiaryEntries(); // 메모를 저장한 후 다시 목록을 업데이트
      } else {
        print("실패: 상태 코드 ${response.statusCode}, 응답 내용: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("저장 실패: ${response.body}")),
        );
      }
    } catch (error) {
      print("오류 발생: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("오류가 발생했습니다: $error")),
      );
    }
  }

  // 서버에서 해당 날짜의 메모 목록을 가져오기
  Future<void> _fetchDiaryEntries() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(widget.selectedDay); // 서버에서 요구하는 날짜 형식
    String? accessToken = await _getAccessToken();

    try {
      final response = await http.get(
        Uri.parse("http://localhost:8080/diary/by-date?date=$formattedDate"),
        headers: {
          "Content-type": "application/json",
          "accessToken": "$accessToken",
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes)); // UTF-8로 디코딩
        print("서버 응답: $jsonResponse"); // 서버로부터 받은 데이터 출력

        List<dynamic> entries = jsonResponse['data'] ?? []; // 'entries' 대신 'data'에서 가져옴

        setState(() {
          _diaryEntries = entries.map<Map<String, dynamic>>((entry) => {
            'name': entry['name'],
            'time': entry['time'],
            'memo': entry['memo'],
            'date': entry['date'],
          }).toList(); // 각 항목을 Map 형식으로 변환하여 저장
        });
      } else {
        print("메모 가져오기 실패: 상태 코드 ${response.statusCode}, 응답 내용: ${response.body}");
      }
    } catch (error) {
      print("오류 발생: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchDiaryEntries(); // 화면이 열릴 때 해당 날짜의 메모를 불러옴
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text("돌봄 다이어리", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // 메모 추가를 위한 다이얼로그를 띄움
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('메모 추가', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(controller: _patientController, decoration: InputDecoration(hintText: "환자명을 입력하세요")),
                              SizedBox(height: 20),
                              TextField(controller: _hourController, decoration: InputDecoration(hintText: "시간을 입력하세요 (HH)"), keyboardType: TextInputType.number),
                              SizedBox(height: 20),
                              TextField(controller: _minuteController, decoration: InputDecoration(hintText: "분을 입력하세요 (MM)"), keyboardType: TextInputType.number),
                              SizedBox(height: 20),
                              TextField(controller: _noteController, decoration: InputDecoration(hintText: "메모 내용을 입력하세요")),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(), // 취소 버튼
                              child: Text('취소', style: TextStyle(fontSize: 15)),
                            ),
                            TextButton(
                              onPressed: () {
                                if (_patientController.text.isNotEmpty && _hourController.text.isNotEmpty && _minuteController.text.isNotEmpty && _noteController.text.isNotEmpty) {
                                  _saveDiary(); // 메모 저장 요청
                                  Navigator.of(context).pop(); // 다이얼로그 닫기
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("모든 필드를 입력하세요!"))); // 필드가 비어 있을 때 경고 메시지
                                }
                              },
                              child: Text('저장', style: TextStyle(fontSize: 15)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("메모 추가", style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(121, 159, 161, 1.0),
                    onPrimary: Colors.black,
                    fixedSize: Size(280, 70),
                  ),
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text("등록된 메모", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                ),
                // 등록된 메모 목록을 출력
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: _diaryEntries.isNotEmpty
                        ? _diaryEntries.map((entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "환자 이름: ${entry['name']}\n시간: ${entry['time']}\n메모: ${entry['memo']}\n날짜: ${entry['date']}",
                        style: TextStyle(fontSize: 25),
                      ),
                    )).toList()
                        : [Text("등록된 메모가 없습니다.", style: TextStyle(fontSize: 20))],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}