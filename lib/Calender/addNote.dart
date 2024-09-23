// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:project/components/custom_appbar.dart';
//
// class AddNoteScreen extends StatefulWidget {
//   final DateTime selectedDay;
//
//   AddNoteScreen({required this.selectedDay});
//
//   @override
//   _AddNoteScreenState createState() => _AddNoteScreenState();
// }
//
// class _AddNoteScreenState extends State<AddNoteScreen> {
//   TextEditingController _patientController = TextEditingController();
//   TextEditingController _noteController = TextEditingController();
//   List<String> _notes = [];
//   String? selectedHour;
//   String? selectedMinute;
//
//   @override
//   Widget build(BuildContext context) {
//     Color appBarColor = Color.fromRGBO(121, 159, 161, 1.0);
//     String formattedDate = DateFormat('yyyy-MM-dd').format(widget.selectedDay);
//
//     List<String> hours = List.generate(24, (index) => index.toString().padLeft(2, '0'));
//     List<String> minutes = List.generate(60, (index) => index.toString().padLeft(2, '0'));
//
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(250, 250, 250, 1.0),
//       appBar: CustomAppBar(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               children: [
//                 SizedBox(height: 20),
//                 Text(
//                   "돌봄 다이어리",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   height: 100,
//                   color: Color.fromRGBO(230, 230, 230, 1.0),
//                   child: Center(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           formattedDate,
//                           style: TextStyle(
//                               fontSize: 30, fontWeight: FontWeight.bold),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         String? dialogSelectedHour = selectedHour;
//                         String? dialogSelectedMinute = selectedMinute;
//                         return StatefulBuilder(
//                           builder: (context, setDialogState) {
//                             return AlertDialog(
//                               title: Text(
//                                 '메모 추가',
//                                 style: TextStyle(
//                                   fontSize: 30,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               content: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   TextField(
//                                     controller: _patientController,
//                                     decoration: InputDecoration(
//                                         hintText: "환자명을 입력하세요"
//                                     ),
//                                   ),
//                                   SizedBox(height: 20,),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       DropdownButton<String>(
//                                         hint: Text("시간 (HH)"),
//                                         value: dialogSelectedHour,
//                                         onChanged: (String? newValue) {
//                                           setDialogState(() {
//                                             dialogSelectedHour = newValue!;
//                                           });
//                                         },
//                                         items: hours.map<DropdownMenuItem<String>>((String value) {
//                                           return DropdownMenuItem<String>(
//                                             value: value,
//                                             child: Text(value),
//                                           );
//                                         }).toList(),
//                                       ),
//                                       DropdownButton<String>(
//                                         hint: Text("분 (MM)"),
//                                         value: dialogSelectedMinute,
//                                         onChanged: (String? newValue) {
//                                           setDialogState(() {
//                                             dialogSelectedMinute = newValue!;
//                                           });
//                                         },
//                                         items: minutes.map<DropdownMenuItem<String>>((String value) {
//                                           return DropdownMenuItem<String>(
//                                             value: value,
//                                             child: Text(value),
//                                           );
//                                         }).toList(),
//                                       ),
//                                     ],
//                                   ),
//                                   TextField(
//                                     controller: _noteController,
//                                     decoration: InputDecoration(
//                                       hintText: "메모 내용을 입력하세요",
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop(); // 다이얼로그 닫기
//                                   },
//                                   child: Text(
//                                     '취소',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     String memoText = _noteController.text;
//                                     String patientName = _patientController.text;
//
//                                     if (memoText.isNotEmpty && dialogSelectedHour != null && dialogSelectedMinute != null && patientName.isNotEmpty) {
//                                       setState(() {
//                                         _notes.add('환자명 : $patientName\n내   용 : $memoText\n시   간 : $dialogSelectedHour:$dialogSelectedMinute');
//                                         _noteController.clear();
//                                         _patientController.clear();
//                                         selectedHour = null;
//                                         selectedMinute = null;
//                                       });
//                                       Navigator.of(context).pop(); // 다이얼로그 닫기
//                                     }
//                                   },
//                                   child: Text(
//                                     '저장',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       },
//                     );
//                   },
//                   child: Text(
//                     "메모 추가",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                     ),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     primary: Color.fromRGBO(121, 159, 161, 1.0), // 배경 색상
//                     onPrimary: Colors.black, // 글자 색상
//                     fixedSize: Size(280, 70), // 버튼 크기
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Text(
//                       "등록된 메모",
//                       style: TextStyle(
//                           fontSize: 30, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: _notes.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(
//                         _notes[index],
//                         style: TextStyle(fontSize: 20),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//

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
  final _formKey2 = GlobalKey<FormState>();
  TextEditingController _patientController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TextEditingController _hourController = TextEditingController();
  TextEditingController _minuteController = TextEditingController();

  List<String> _diaryEntries = [];

  Future<String?> _getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

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
      "date": DateFormat('yyyyMMdd').format(widget.selectedDay),
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

      // 요청 성공 시 처리
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("성공적으로 저장되었습니다!")),
        );
        _fetchDiaryEntries();
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
  //
  // Future<void> _fetchDiaryEntries() async {
  //   String formattedDate = DateFormat('yyyy-MM-dd').format(widget.selectedDay);
  //   String? accessToken = await _getAccessToken();
  //
  //   try {
  //     final response = await http.get(
  //       Uri.parse("http://localhost:8080/diary/by-date?date=$formattedDate"),
  //       headers: {
  //         "accessToken": "$accessToken",
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  //       List<dynamic> entries = jsonResponse['entries'];
  //
  //       setState(() {
  //         _diaryEntries = entries.map<String>((entry) => entry['memo'] as String).toList();
  //       });
  //     } else {
  //       print("메모 가져오기 실패: 상태 코드 ${response.statusCode}, 응답 내용: ${response.body}");
  //     }
  //   } catch (error) {
  //     print("오류 발생: $error");
  //   }
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _fetchDiaryEntries();
  // }

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
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('취소', style: TextStyle(fontSize: 15)),
                            ),
                            TextButton(
                              onPressed: () {
                                if (_patientController.text.isNotEmpty && _hourController.text.isNotEmpty && _minuteController.text.isNotEmpty && _noteController.text.isNotEmpty) {
                                  _saveDiary();
                                  Navigator.of(context).pop();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("모든 필드를 입력하세요!")));
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: _diaryEntries.map((entry) => Text(entry, style: TextStyle(fontSize: 20))).toList(),
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