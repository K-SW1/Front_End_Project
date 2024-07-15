import 'package:flutter/material.dart';
import 'package:project/Custom/custom_size.dart';
import 'package:project/components/custom_regist_form.dart';


class RegistPage extends StatelessWidget {
  RegistPage({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    Color appBarColor = Color.fromRGBO(121,159,165,1.0);
    return Scaffold(
      backgroundColor: appBarColor,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 100),
            Center(
              child: Image(
                image: AssetImage('assets/images/recall_splash.png'),
                  fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: xlarge_gap,),
            SizedBox(height: large_gap,),
            SizedBox(height: large_gap,),
            // CustomRegistForm(),
          ],
        ),
      ),
    );
  }
}
