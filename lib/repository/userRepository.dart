import 'dart:io';

import 'package:baykurs/ui/profile/model/UserUpdateResponse.dart';
import 'package:baykurs/ui/register/model/RegisterRequest.dart';
import 'package:baykurs/ui/register/model/RegisterResponse.dart';
import 'package:baykurs/ui/timesheet/model/TimeSheetResponse.dart';
import 'package:dio/dio.dart';

import '../service/APIService.dart';
import '../service/ResultResponse.dart';
import '../service/apiUrls.dart';
import '../ui/login/model/LoginRequest.dart';
import '../ui/login/model/LoginResponse.dart';
import '../ui/profile/model/ProfileResponse.dart';
import '../ui/profile/model/UserUpdateRequest.dart';

class UserRepository {
  Future<ResultResponse<LoginResponse>> postLogin(LoginRequest request) async {
    try {
      final response = await APIService.instance.request(
          ApiUrls.loginUrl,
          param: request.toJson(),
          DioMethod.post,
          includeHeaders: false);

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

  Future<ResultResponse<RegisterResponse>> postRegister(
      RegisterRequest request) async {
    try {
      final response = await APIService.instance.request(
          ApiUrls.register,
          param: request.toJson(),
          DioMethod.post,
          includeHeaders: false);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        RegisterResponse registerResponse = RegisterResponse.fromJson(body);

        return ResultResponse.success(registerResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        print('DioError: ${e.response?.data}');
        if (e.response != null && e.response!.data is Map<String, dynamic>) {
          String errorMessage =
              e.response!.data['message'] ?? 'Bir hata oluştu.';
          return ResultResponse.failure(errorMessage);
        }
      }
      print(e.toString());
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<ProfileResponse>> getUserProfile() async {
    try {
      final response =
          await APIService.instance.request(ApiUrls.userProfile, DioMethod.get);

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

  Future<ResultResponse<TimeSheetResponse>> getUserTimeSheet() async {
    try {
      final response = await APIService.instance
          .request(ApiUrls.getTimeSheet, DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        TimeSheetResponse timeSheetResponse = TimeSheetResponse.fromJson(body);

        return ResultResponse.success(timeSheetResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<UserUpdateResponse>> updateUserInfo(
      UserUpdateRequestModel request) async {
    try {
      final response = await APIService.instance.request(
          ApiUrls.updateUser,
          param: request.toJson(),
          DioMethod.patch,
          includeHeaders: true);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        UserUpdateResponse userUpdateResponse =
            UserUpdateResponse.fromJson(body);

        return ResultResponse.success(userUpdateResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        print('DioError: ${e.response?.data}');
        if (e.response != null && e.response!.data is Map<String, dynamic>) {
          String errorMessage =
              e.response!.data['message'] ?? 'Bir hata oluştu.';
          return ResultResponse.failure(errorMessage);
        }
      }
      print(e.toString());
      return ResultResponse.failure('Exception: $e');
    }
  }
}
