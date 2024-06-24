import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:yeni_okul/service/apiUrls.dart';
import 'package:yeni_okul/service/result.dart';
import 'package:yeni_okul/ui/login/model/LoginResponse.dart';

import '../service/APIService.dart';

class UserRepository {
  Future<Result<dynamic>> loginService(String email, String password,
      String token) async {
    try {
      final response = await APIService.instance.request(
        loginUrl,
        token,
        DioMethod.post,
        param: {'email': email, 'password': password},
        contentType: 'application/json',
      );

      Map<String, dynamic> results = json.decode(response.data);
      LoginResponse user = LoginResponse.fromJson(results);
      return Success(user.token);
    } on DioException catch (error) {
      return ResultError(error.message.toString());
    }
  }
}
