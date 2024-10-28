import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:project/components/custom_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageQuizAddPage extends StatefulWidget {
  @override
  _ImageQuizAddPageState createState() => _ImageQuizAddPageState();
}

class _ImageQuizAddPageState extends State<ImageQuizAddPage> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _hintController = TextEditingController();
  final _answer1Controller = TextEditingController();
  final _answer2Controller = TextEditingController();
  final _answer3Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool? _validation1;
  bool? _validation2;
  bool? _validation3;
  int? _imageQuizId;
  File? _selectedImage;

  @override
  void dispose() {
    _questionController.dispose();
    _hintController.dispose();
    _answer1Controller.dispose();
    _answer2Controller.dispose();
    _answer3Controller.dispose();
    super.dispose();
  }

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
      request.headers['accessToken'] = accessToken;

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
          final responseData = await response.stream.bytesToString();
          final jsonData = jsonDecode(responseData);

          setState(() {
            _imageQuizId = jsonData['data']['imageQuizId'];
          });


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

  Future<void> _saveAnswerAndCorrect() async {
    if(_formKey.currentState?.validate() ?? false) {
      if(_imageQuizId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('먼저 문제와 힌트를 입력해주세요.')),
        );
        return;
      }

      String? accessToken = await _getAccessToken();
      if(accessToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('로그인 정보가 없습니다. 다시 로그인 해주세요.')),
        );
        return;
      }

      final distractors = [
        {
          'imageQuizId' : _imageQuizId,
          'imageQuizDistractor' : _answer1Controller.text,
          'validation' : _validation1 ?? false,
        },
        {
          'imageQuizId' : _imageQuizId,
          'imageQuizDistractor' : _answer2Controller.text,
          'validation' : _validation2 ?? false,
        },
        {
          'imageQuizId' : _imageQuizId,
          'imageQuizDistractor' : _answer3Controller.text,
          'validation' : _validation3 ?? false,
        },
      ];

      try {
        for (var distractor in distractors) {
          final response = await http.post(
            Uri.parse('http://localhost:8080/imagequizDistractor/$_imageQuizId/distractor/add'),
            headers: {
              'Content-Type' : 'application/json',
              'accessToken' : '$accessToken',
            },
            body: jsonEncode(distractor),
          );
          if(response.statusCode != 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('보기와 정답 저장에 실패했습니다 :${response.statusCode}')),
            );
            return;
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('보기와 정답이 성공적으로 저장되었습니다.')),
        );
      }
      catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('보기와 정답 저장 중 오류가 발생했습니다: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(  // SingleChildScrollView 추가
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _questionController,
                  decoration: InputDecoration(labelText: '문제'),
                  validator: (value) => value == null || value.isEmpty ? '질문을 입력하세요' : null,
                ),
                TextFormField(
                  controller: _hintController,
                  decoration: InputDecoration(labelText: '힌트'),
                  validator: (value) => value == null || value.isEmpty ? '힌트를 입력하세요' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('사진을 선택하세요'),
                ),
                SizedBox(height: 20),
                _selectedImage != null
                    ? Image.file(_selectedImage!, height: 200)
                    : Text('No image selected'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addImageQuiz,
                  child: Text('문제 저장하기'),
                ),
                SizedBox(height: 20),
                Text(
                  "보기 및 정답",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10),
                CustomTextAnswer(
                  controller: _answer1Controller,
                  label: '보기 1',
                  onValidationChanged: (value) {
                    setState(() {
                      _validation1 = value;
                    });
                  },
                ),
                CustomTextAnswer(
                  controller: _answer2Controller,
                  label: '보기 2',
                  onValidationChanged: (value) {
                    setState(() {
                      _validation2 = value;
                    });
                  },
                ),
                CustomTextAnswer(
                  controller: _answer3Controller,
                  label: '보기 3',
                  onValidationChanged: (value) {
                    setState(() {
                      _validation3 = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(onPressed: _saveAnswerAndCorrect,
                      child: Text(
                        '보기와 정답 저장',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}


class CustomTextAnswer extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Function(bool) onValidationChanged;

  CustomTextAnswer({
    required this.controller,
    required this.label,
    required this.onValidationChanged,
  });

  @override
  _CustomTextAnswerState createState() => _CustomTextAnswerState();
}

class _CustomTextAnswerState extends State<CustomTextAnswer> {
  bool _isCorrect = false; // Internal state to track the correct answer

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 1,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '텍스트를 입력해주세요';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text("정답 여부:"),
              SizedBox(width: 10),
              ChoiceChip(
                label: Text('정답'),
                selected: _isCorrect,
                onSelected: (selected) {
                  setState(() {
                    _isCorrect = selected;
                    widget.onValidationChanged(_isCorrect); // Notify parent widget
                  });
                },
              ),
              SizedBox(width: 10),
              ChoiceChip(
                label: Text('거짓'),
                selected: !_isCorrect,
                onSelected: (selected) {
                  setState(() {
                    _isCorrect = !selected;
                    widget.onValidationChanged(_isCorrect); // Notify parent widget
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}