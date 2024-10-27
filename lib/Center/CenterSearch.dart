import 'package:flutter/material.dart';
import 'package:project/aasd/teste.dart';
import 'package:project/components/custom_appbar.dart';
import 'package:project/components/custom_textquiz_form.dart';
//
// void main() => runApp(CenterSearch());

class CenterSearch extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Color appBarColor = Color.fromRGBO(121,159,165,1.0);
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "데이케어 센터 검색",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                CustomTextForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
