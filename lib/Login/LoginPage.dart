import 'package:flutter/material.dart';
import 'package:project/Custom/custom_size.dart';
import 'package:project/components/custom_form.dart';


class LoginPage extends StatelessWidget {
  LoginPage({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(121,159,165,1.0),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 100),
            Center(
              child: Image(
                image: AssetImage('assets/images/recall_splash.png'),
                fit: BoxFit.contain,
                color: Colors.black,
              ),
            ),
            SizedBox(height: xlarge_gap,),
            SizedBox(height: large_gap,),
            CustomForm(),
          ],
        ),
      ),
    );
  }
}
