import 'package:flutter/material.dart';
import 'package:project/Custom/custom_size.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;
  const CustomTextFormField(this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        SizedBox(height: small_gap,),
        TextFormField(
          // 유효성 체크
          // 공백일 경우 메세지 출력
          validator: (value) => value!.isEmpty
              ? "필수항목입니다"
              :  null,

          // text가 password일 경우 마킹 처리 true
          obscureText: text == "Password" ? true : false,

          // 힌트 문자 및 데코레이션 기능 추가
          decoration: InputDecoration(
            hintText: "Enter $text",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),


        )
      ],
    );
  }
}
