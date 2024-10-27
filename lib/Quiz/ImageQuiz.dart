import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageQuizAddPage extends StatefulWidget {
  @override
  _ImageQuizAddPageState createState() => _ImageQuizAddPageState();
}

class _ImageQuizAddPageState extends State<ImageQuizAddPage> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _hintController = TextEditingController();
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<String?> _getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<void> _addImageQuiz() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('이미지를 선택해주세요')),
        );
        return;
      }

      String? accessToken = await _getAccessToken();
      if (accessToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('로그인 정보가 없습니다. 다시 로그인 해주세요.')),
        );
        return;
      }

      final uri = Uri.parse('http://localhost:8080/imagequiz/add');
      final request = http.MultipartRequest('POST', uri);

      // 헤더에 accessToken 추가
      request.headers['accessToken'] = accessToken;

      // JSON 형식으로 question과 hint를 추가
      final quizData = jsonEncode({
        'question': _questionController.text,
        'hint': _hintController.text,
      });
      request.files.add(
        http.MultipartFile.fromString(
          'imageQuiz',
          quizData,
          contentType: MediaType('application', 'json'),
        ),
      );

      // 이미지 파일을 multipart/form-data 형식으로 추가
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          _selectedImage!.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      try {
        final response = await request.send();

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('이미지 퀴즈가 성공적으로 저장되었습니다!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('저장에 실패했습니다: ${response.statusCode}')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('저장 중 오류가 발생했습니다: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Image Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: InputDecoration(labelText: 'Question'),
                validator: (value) => value == null || value.isEmpty ? '질문을 입력하세요' : null,
              ),
              TextFormField(
                controller: _hintController,
                decoration: InputDecoration(labelText: 'Hint'),
                validator: (value) => value == null || value.isEmpty ? '힌트를 입력하세요' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Select Image from Gallery'),
              ),
              SizedBox(height: 20),
              _selectedImage != null
                  ? Image.file(_selectedImage!, height: 200)
                  : Text('No image selected'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addImageQuiz,
                child: Text('Add Image Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}