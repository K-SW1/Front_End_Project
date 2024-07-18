import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Regist/RegistMain.dart';

void main() {runApp(RegistAgree());}

class RegistAgree extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(121,159,165,1.0),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(121,159,165,1.0),
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: IdRegist(),
    );
  }
}


class IdRegist extends StatefulWidget {

  @override
  State<IdRegist> createState() => _TermsOfServiceAgreementState();

}

class _TermsOfServiceAgreementState extends State<IdRegist> {
  List<bool> _isChecked = List.generate(5, (_) => false);

  bool get _buttonActive => _isChecked[1] && _isChecked[2] && _isChecked[3];

  void _updateCheckState(int index) {
    setState(() {
      // 모두 동의 체크박스일 경우
      if (index == 0) {
        bool isAllChecked = !_isChecked.every((element) => element);
        _isChecked = List.generate(5, (index) => isAllChecked);
      } else {
        _isChecked[index] = !_isChecked[index];
        _isChecked[0] = _isChecked.getRange(1, 5).every((element) => element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(121,159,161,1.0),
        elevation: 0,
        title: Text("회원가입 약관 동의",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.black),),
      ),
      backgroundColor: Color.fromRGBO(121,159,161,1.0),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            ..._renderCheckList(),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100003,50),
                      backgroundColor: _buttonActive ? Colors.blue : Color.fromRGBO(121,159,161,1.0),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Get.to(()=> RegistMain());
                    },
                    child: const Text('가입하기',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _renderCheckList() {
    List<String> labels = [
      '모두 동의',
      '만 14세 이상입니다.(필수)',
      '개인정보처리방침(필수)',
      '서비스 이용 약관(필수)',
      '이벤트 및 할인 혜택 안내 동의(선택)',
    ];

    List<Widget> list = [
      renderContainer(_isChecked[0], labels[0], () => _updateCheckState(0)),
      const Divider(thickness: 1.0),
    ];

    list.addAll(List.generate(4, (index) => renderContainer(_isChecked[index + 1], labels[index + 1], () => _updateCheckState(index + 1))));

    return list;
  }

  Widget renderContainer(bool checked, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: checked ? Colors.blue : Colors.grey, width: 2.0),
                color: checked ? Colors.blue : Colors.white,
              ),
              child: Icon(Icons.check, color: checked ? Colors.white : Colors.grey, size: 18),
            ),
            const SizedBox(width: 15),
            Text(text, style: const TextStyle(color: Colors.black, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}