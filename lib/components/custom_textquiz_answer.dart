import 'package:flutter/material.dart';

class CustomTextAnswer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // 원하는 너비로 설정
      padding: EdgeInsets.symmetric(horizontal: 20), // 양옆에 패딩 추가
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 5,
              )
          ),
        ),
      ),
    );
  }
}

//
// class CustomTextAnswer extends StatelessWidget {
//   final TextEditingController controller;
//
//   CustomTextAnswer({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return '텍스트를 입력해주세요';
//         }
//         return null;
//       },
//     );
//   }
// }