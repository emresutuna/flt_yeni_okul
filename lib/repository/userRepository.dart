import 'dart:io';

import '../service/APIService.dart';
import '../service/ResultResponse.dart';
import '../service/apiUrls.dart';
import '../ui/login/model/LoginRequest.dart';
import '../ui/login/model/LoginResponse.dart';
import '../ui/profile/model/ProfileResponse.dart';

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
