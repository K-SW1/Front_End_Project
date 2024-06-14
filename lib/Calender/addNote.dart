import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/components/custom_appbar.dart';

class AddNoteScreen extends StatefulWidget {
  final DateTime selectedDay;

  AddNoteScreen({required this.selectedDay});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color appBarColor = Color.fromRGBO(121,159,161,1.0);
    String formattedDate = DateFormat('yyyy-MM-dd').format(widget.selectedDay);

    return Scaffold(
      backgroundColor: Color.fromRGBO(250,250,250,1.0),
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "돌봄 다이어리",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 100,
                  color: Color.fromRGBO(230,230,230,1.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formattedDate,
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String? memoText;

                        return AlertDialog(
                          title: Text(
                            '메모 추가',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: TextField(
                            onChanged: (value) {
                              memoText = value;
                            },
                            decoration: InputDecoration(
                              hintText: "메모 내용을 입력하세요",
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // 다이얼로그 닫기
                              },
                              child: Text(
                                '취소',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // 여기서 메모 저장 작업을 수행
                                print('저장된 메모: $memoText');
                                Navigator.of(context).pop(); // 다이얼로그 닫기
                              },
                              child: Text(
                                '저장',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    "메모 추가",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(121, 159, 161, 1.0), // 배경 색상
                    onPrimary: Colors.black, // 글자 색상
                    fixedSize: Size(280, 70), // 버튼 크기
                  ),
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "등록된 메모", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                    ),
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
