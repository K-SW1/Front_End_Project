import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메모 앱'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String? memoText;
                    return AlertDialog(
                      title: Text('메모 추가',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),
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
                          child: Text('취소',style: TextStyle(fontWeight: FontWeight.bold,fontSize:15),),
                        ),
                        TextButton(
                          onPressed: () {
                            // 여기서 메모 저장 작업을 수행
                            print('저장된 메모: $memoText');
                            Navigator.of(context).pop(); // 다이얼로그 닫기
                          },
                          child: Text('저장',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                "메모 추가",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(121, 159, 161, 1.0), // 배경 색상
                onPrimary: Colors.black, // 글자 색상
                fixedSize: Size(280, 70), // 버튼 크기
              ),
            ),
            SizedBox(height: 30),
            Text(
              "등록된 메모",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
