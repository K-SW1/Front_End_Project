import 'dart:convert';
import 'package:http/http.dart' as http;

class QuizService {
  final String baseUrl;

  QuizService({required this.baseUrl});

  Future<List<QuizDetails>> fetchQuizDetails(int textQuizId) async {
    final response = await http.get(Uri.parse('$baseUrl/textquizDistractor/$textQuizId/details'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => QuizDetails.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load quiz details');
    }
  }
}

class QuizDetails {
  final String creationDate;

  QuizDetails({required this.creationDate});

  factory QuizDetails.fromJson(Map<String, dynamic> json) {
    return QuizDetails(
      creationDate: json['creationDate'],
    );
  }
}
