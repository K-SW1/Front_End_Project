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
//                         return AlertDialog(
//                           title: Text(
//                             '메모 추가',
//                             style: TextStyle(
//                               fontSize: 30,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           content: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   DropdownButton<String>(
//                                     hint: Text("시간 (HH)"),
//                                     value: selectedHour,
//                                     onChanged: (String? newValue) {
//                                       setState(() {
//                                         selectedHour = newValue!;
//                                       });
//                                     },
//                                     items: hours.map<DropdownMenuItem<String>>((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                   ),
//                                   DropdownButton<String>(
//                                     hint: Text("분 (MM)"),
//                                     value: selectedMinute,
//                                     onChanged: (String? newValue) {
//                                       setState(() {
//                                         selectedMinute = newValue!;
//                                       });
//                                     },
//                                     items: minutes.map<DropdownMenuItem<String>>((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ],
//                               ),
//                               TextField(
//                                 controller: _noteController,
//                                 decoration: InputDecoration(
//                                   hintText: "메모 내용을 입력하세요",
//                                 ),
//                               ),
//                             ],
//                           ),
//                           actions: [
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop(); // 다이얼로그 닫기
//                               },
//                               child: Text(
//                                 '취소',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 String memoText = _noteController.text;
//
//                                 if (memoText.isNotEmpty && selectedHour != null && selectedMinute != null) {
//                                   setState(() {
//                                     _notes.add('$memoText - $selectedHour:$selectedMinute');
//                                   });
//                                 }
//                                 Navigator.of(context).pop(); // 다이얼로그 닫기
//                               },
//                               child: Text(
//                                 '저장',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                             ),
//                           ],
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
  List<String> _notes = [];
  String? selectedHour;
  String? selectedMinute;

  @override
  Widget build(BuildContext context) {
    Color appBarColor = Color.fromRGBO(121, 159, 161, 1.0);
    String formattedDate = DateFormat('yyyy-MM-dd').format(widget.selectedDay);

    List<String> hours = List.generate(24, (index) => index.toString().padLeft(2, '0'));
    List<String> minutes = List.generate(60, (index) => index.toString().padLeft(2, '0'));

    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1.0),
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
                  color: Color.fromRGBO(230, 230, 230, 1.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formattedDate,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
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
                        String? dialogSelectedHour = selectedHour;
                        String? dialogSelectedMinute = selectedMinute;
                        return StatefulBuilder(
                          builder: (context, setDialogState) {
                            return AlertDialog(
                              title: Text(
                                '메모 추가',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      DropdownButton<String>(
                                        hint: Text("시간 (HH)"),
                                        value: dialogSelectedHour,
                                        onChanged: (String? newValue) {
                                          setDialogState(() {
                                            dialogSelectedHour = newValue!;
                                          });
                                        },
                                        items: hours.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                      DropdownButton<String>(
                                        hint: Text("분 (MM)"),
                                        value: dialogSelectedMinute,
                                        onChanged: (String? newValue) {
                                          setDialogState(() {
                                            dialogSelectedMinute = newValue!;
                                          });
                                        },
                                        items: minutes.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  TextField(
                                    controller: _noteController,
                                    decoration: InputDecoration(
                                      hintText: "메모 내용을 입력하세요",
                                    ),
                                  ),
                                ],
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
                                    String memoText = _noteController.text;

                                    if (memoText.isNotEmpty && dialogSelectedHour != null && dialogSelectedMinute != null) {
                                      setState(() {
                                        _notes.add('$memoText - $dialogSelectedHour:$dialogSelectedMinute');
                                        _noteController.clear();
                                        selectedHour = null;
                                        selectedMinute = null;
                                      });
                                      Navigator.of(context).pop(); // 다이얼로그 닫기
                                    }
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
                      "등록된 메모",
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _notes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _notes[index],
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
