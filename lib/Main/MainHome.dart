import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Main/Second.dart';
import 'package:project/Main/first.dart';
import 'package:project/components/custom_leading_button.dart';

void main() => runApp(MainHome());

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: home(),
    );
  }
}

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.to(() => Second());
          },
          icon: Icon(Icons.account_circle,size: 30,),
        ),
        actions: [
          IconButton(onPressed: () {
            Get.to(() => first());
          },
              icon: Icon(Icons.notifications_active_outlined,size: 30,))
        ],
          backgroundColor: Colors.lightBlue,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("RecallQuest",style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),)),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 300,
              height: 100,
              color: Colors.white10,
              child: Center(
                child: Text(
                  "1",style: TextStyle(fontSize: 30),
                ),
              ),

            ),
            Divider(thickness: 3,color: Colors.black,),
            Container(
              width: 300,
              height: 100,
              color: Colors.white10,
              child: Center(
                child: Text(
                  "2",style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Divider(thickness: 3,color: Colors.black,),
            Container(
              width: 300,
              height: 100,
              color: Colors.white10,
              child: Center(
                child: Text(
                  "3",style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Divider(thickness: 3,color: Colors.black,),
            Container(
              width: 300,
              height: 100,
              color: Colors.white10,
              child: Center(
                child: Text(
                  "4",style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Divider(thickness: 3,color: Colors.black,),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.phone,size: 35,),
            label: ""
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home,size: 35,),
            label: "",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle,size: 35,),
            label: "",
          )
        ],
      )
    );
  }
}
