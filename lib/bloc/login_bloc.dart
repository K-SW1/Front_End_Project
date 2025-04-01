import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:project/bloc/login_event.dart';
import 'package:project/bloc/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': event.username,
          'password': event.password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('accessToken', data['accessToken']);
        await prefs.setString('username', event.username);

        emit(LoginSuccess());
      } else if (response.statusCode == 401) {
        emit(LoginFailure(error: 'ID/PW를 다시 입력하세요'));
      } else {
        emit(LoginFailure(error: '로그인 실패 (상태 코드: ${response.statusCode})'));
      }
    } catch (e) {
      emit(LoginFailure(error: '네트워크 오류: $e'));
    }
  }
}