import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/components/custom_appbar.dart';

void main() {
  runApp(Missing());
}

class Missing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MissingPersonsScreen(),
    );
  }
}

class MissingPerson {
  final String name;
  final String age;
  final String date;
  final String area;
  final String gender;
  final String img;

  MissingPerson({
    required this.name,
    required this.age,
    required this.date,
    required this.area,
    required this.gender,
    required this.img,
  });

  factory MissingPerson.fromJson(Map<String, dynamic> json) {
    return MissingPerson(
      name: json['name'],
      age: json['age'],
      date: json['date'],
      area: json['area'],
      gender: json['gender'],
      img: json['img'],
    );
  }
}

Future<List<MissingPerson>> fetchMissingPersons() async {
  final response = await http.get(Uri.parse('http://localhost:8080/missing/all'));

  if (response.statusCode == 200) {
    // 응답을 UTF-8로 디코딩
    String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> jsonResponse = json.decode(responseBody);
    List<dynamic> data = jsonResponse['data'];

    return data.map((json) => MissingPerson.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load missing persons');
  }
}

class MissingPersonsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder<List<MissingPerson>>(
        future: fetchMissingPersons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No missing persons found'));
          } else {
            List<MissingPerson> persons = snapshot.data!;
            return ListView.builder(
              itemCount: persons.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('이름: ${persons[index].name}',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text('나이: ${persons[index].age}', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text('실종날짜: ${persons[index].date}', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text('지역: ${persons[index].area}', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text('성별: ${persons[index].gender}', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          persons[index].img.isNotEmpty
                              ? Image.network(persons[index].img)
                              : Text('사진이 존재하지 않음', style: TextStyle(fontSize: 16, color: Colors.red)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}