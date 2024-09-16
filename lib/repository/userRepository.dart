import 'dart:io';
import 'package:yeni_okul/service/apiUrls.dart';
import 'package:yeni_okul/ui/login/model/LoginRequest.dart';
import 'package:yeni_okul/ui/login/model/LoginResponse.dart';
import 'package:yeni_okul/ui/profile/model/ProfileResponse.dart';

import '../service/APIService.dart';
import '../service/ResultResponse.dart';

class UserRepository {
  Future<ResultResponse<LoginResponse>> postLogin(LoginRequest request) async {
    try {
      final response = await APIService.instance
          .request(loginUrl, param: request.toJson(), DioMethod.post);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        LoginResponse loginResponse = LoginResponse.fromJson(body);

        return ResultResponse.success(loginResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<ProfileResponse>> getUserProfile() async {
    try {
      final response = await APIService.instance
          .request(userProfile, DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        ProfileResponse profileResponse = ProfileResponse.fromJson(body);

        return ResultResponse.success(profileResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      return ResultResponse.failure('Exception: $e');
    }
  }
}
