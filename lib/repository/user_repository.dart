import 'dart:io';
import 'package:baykurs/ui/dashboard/model/mobile_home_response.dart';
import 'package:baykurs/ui/favoriteschool/model/favorite_school_response.dart';
import 'package:baykurs/ui/forgotpassword/forgot_password_request.dart';
import 'package:baykurs/ui/forgotpassword/ForgotPasswordResponse.dart';
import 'package:baykurs/ui/notification/model/NotificationResponse.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/model/PaymentBillResponse.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/model/SingleBillResponse.dart';
import 'package:baykurs/ui/profile/bloc/ProfileBloc.dart';
import 'package:baykurs/ui/profile/model/DeleteAccountResponse.dart';
import 'package:baykurs/ui/profile/model/EducationInformationRequest.dart';
import 'package:baykurs/ui/profile/model/EducationInformationResponse.dart';
import 'package:baykurs/ui/profile/model/LogoutResponse.dart';
import 'package:baykurs/ui/profile/model/UserUpdateResponse.dart';
import 'package:baykurs/ui/register/model/RegisterRequest.dart';
import 'package:baykurs/ui/register/model/RegisterResponse.dart';
import 'package:baykurs/ui/requestlesson/model/CourseRequest.dart';
import 'package:baykurs/ui/timesheet/model/TimeSheetResponse.dart';
import 'package:baykurs/util/SharedPrefHelper.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';

import '../service/api_service.dart';
import '../service/handle_api_exception.dart';
import '../service/result_response.dart';
import '../service/api_urls.dart';
import '../ui/favoriteschool/model/favorite_toggle_response.dart';
import '../ui/login/model/login_request.dart';
import '../ui/login/model/login_response.dart';
import '../ui/payment/makePayment/paymentBill/model/BillResultResponse.dart';
import '../ui/profile/model/ProfileResponse.dart';
import '../ui/profile/model/UserUpdateRequest.dart';
import '../ui/requestlesson/model/CourseRequestResponse.dart';

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
        includeHeaders: false,
      );
      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        RegisterResponse registerResponse = RegisterResponse.fromJson(body);

        return ResultResponse.success(registerResponse);
      } else {
        final responseData = response.data as Map<String, dynamic>;

        String errorMessage = "";

        if (responseData['errors'] != null) {
          final errors = responseData['errors'] as Map<String, dynamic>;

          final Map<String, String> fieldNames = {
            'email': 'E-Posta',
            'phone': 'Telefon',
            'password': 'Şifre',
            'name': 'Ad',
            'surname': 'Soyad',
          };

          errorMessage = errors.entries.map((entry) {
            String fieldKey = entry.key;
            String fieldName = fieldNames[fieldKey] ?? fieldKey;
            String messages = (entry.value as List).join(", ");
            return "$fieldName: $messages";
          }).join("\n");
        } else if (responseData['message'] != null) {
          errorMessage = responseData['message'];
        } else {
          errorMessage =
              'API call failed with status code ${response.statusCode}';
        }

        return ResultResponse.failure(errorMessage);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.data is Map<String, dynamic>) {
          final responseData = e.response!.data as Map<String, dynamic>;

          String errorMessage = "";

          if (responseData['errors'] != null) {
            final errors = responseData['errors'] as Map<String, dynamic>;

            final Map<String, String> fieldNames = {
              'email': 'E-Posta',
              'phone': 'Telefon',
              'password': 'Şifre',
              'name': 'Ad',
              'surname': 'Soyad',
            };

            errorMessage = errors.entries.map((entry) {
              String fieldKey = entry.key;
              String fieldName = fieldNames[fieldKey] ?? fieldKey;
              String messages = (entry.value as List).join(", ");
              return "$fieldName: $messages";
            }).join("\n");
          } else if (responseData['message'] != null) {
            errorMessage = responseData['message'];
          } else {
            errorMessage = "Bir hata oluştu";
          }
          return ResultResponse.failure(errorMessage);
        }
      }

      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<ForgotPasswordResponse>> postForgotPassword(
      ForgotPasswordRequest request) async {
    try {
      final response = await APIService.instance.request(
          ApiUrls.forgotPassword,
          param: request.toJson(),
          DioMethod.post,
          includeHeaders: true);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        ForgotPasswordResponse forgotPasswordResponse =
            ForgotPasswordResponse.fromJson(body);

        return ResultResponse.success(forgotPasswordResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.data is Map<String, dynamic>) {
          String errorMessage =
              e.response!.data['message'] ?? 'Bir hata oluştu.';
          return ResultResponse.failure(errorMessage);
        }
      }
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<DeleteAccountResponse>> deleteAccount() async {
    try {
      final response = await APIService.instance
          .request(ApiUrls.deleteAccount, DioMethod.post, includeHeaders: true);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        DeleteAccountResponse deleteAccountResponse =
            DeleteAccountResponse.fromJson(body);

        return ResultResponse.success(deleteAccountResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.data is Map<String, dynamic>) {
          String errorMessage =
              e.response!.data['message'] ?? 'Bir hata oluştu.';
          return ResultResponse.failure(errorMessage);
        }
      }
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<LogoutResponse>> logout() async {
    try {
      final response = await APIService.instance
          .request(ApiUrls.logout, DioMethod.post, includeHeaders: true);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        LogoutResponse logoutResponse = LogoutResponse.fromJson(body);
        return ResultResponse.success(logoutResponse);
      } else if (response.statusCode == HttpStatus.unauthorized) {
        Map<String, dynamic> body = response.data;
        LogoutResponse logoutResponse = LogoutResponse.fromJson(body);
        return ResultResponse.success(logoutResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.data is Map<String, dynamic>) {
          String errorMessage =
              e.response!.data['message'] ?? 'Bir hata oluştu.';

          if (e.response?.statusCode == HttpStatus.unauthorized) {
            LogoutResponse logoutResponse =
                LogoutResponse.fromJson(e.response!.data);
            return ResultResponse.success(logoutResponse);
          }

          return ResultResponse.failure(errorMessage);
        }
      }
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<ProfileResponse>> getUserProfile() async {
    try {
      final response = await APIService.instance.request(
        ApiUrls.userProfile,
        DioMethod.get,
      );

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        ProfileResponse profileResponse = ProfileResponse.fromJson(body);
        return ResultResponse.success(profileResponse);
      } else if (response.statusCode == HttpStatus.forbidden) {
        return ResultResponse.failure(MailNotVerifiedFailure());
      } else {
        return ResultResponse.failure(GenericFailure());
      }
    } catch (e) {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;

        if (statusCode == HttpStatus.forbidden) {
          return ResultResponse.failure(MailNotVerifiedFailure());
        }
        return ResultResponse.failure(GenericFailure());
      }

      return ResultResponse.failure(GenericFailure());
    }
  }

  Future<ResultResponse<NotificationResponse>> getNotifications() async {
    try {
      final response = await APIService.instance
          .request(ApiUrls.userNotification, DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        NotificationResponse profileResponse =
            NotificationResponse.fromJson(body);

        return ResultResponse.success(profileResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<NotificationResponse>> updateNotificationSeen() async {
    try {
      final response = await APIService.instance
          .request(ApiUrls.userNotificationSeen, DioMethod.post);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        NotificationResponse profileResponse =
            NotificationResponse.fromJson(body);

        return ResultResponse.success(profileResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<TimeSheetResponse>> getUserTimeSheet() async {
    try {
      final response = await APIService.instance.request(
          "${ApiUrls.getTimeSheet}?end=2025-03-30", DioMethod.get,
          includeHeaders: true);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        TimeSheetResponse timeSheetResponse = TimeSheetResponse.fromJson(body);

        return ResultResponse.success(timeSheetResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
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
        includeHeaders: true,
      );

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
        return handleDioException<UserUpdateResponse>(e);
      }
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<EducationInformationResponse>> updateEducationInfo(
      EducationInformationRequest request) async {
    try {
      final response = await APIService.instance.request(
        ApiUrls.updateEducationInfo,
        param: request.toJson(),
        DioMethod.patch,
        includeHeaders: true,
      );

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        EducationInformationResponse educationInformationResponse =
            EducationInformationResponse.fromJson(body);

        return ResultResponse.success(educationInformationResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        return handleDioException<EducationInformationResponse>(e);
      }
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<PaymentBillResponse>> getPaymentBills() async {
    try {
      final response = await APIService.instance
          .request(ApiUrls.getBillAddress, DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        if (response.data is! Map<String, dynamic>) {
          return ResultResponse.failure(
            'İşleminizi şu anda gerçekleştiremedik, lütfen daha sonra tekrar deneyin.',
          );
        }

        Map<String, dynamic> body = response.data;
        PaymentBillResponse billResponse = PaymentBillResponse.fromJson(body);

        return ResultResponse.success(billResponse);
      } else if (response.statusCode == HttpStatus.forbidden) {
        return ResultResponse.failure(mailNotVerifiedFailure);
      } else {
        return ResultResponse.failure(
          'API call failed with status code ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;

        if (statusCode == HttpStatus.forbidden) {
          return ResultResponse.failure(mailNotVerifiedFailure);
        }

        return ResultResponse.failure(
          'DioException: ${e.message} (status: $statusCode)',
        );
      }

      return ResultResponse.failure(
        'İşleminizi şu anda gerçekleştiremedik, lütfen daha sonra tekrar deneyin.',
      );
    }
  }


  Future<ResultResponse<SingleBillResponse>> getSinglePaymentBill(
      int id) async {
    try {
      final response = await APIService.instance
          .request(ApiUrls.singleBil(id), DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        SingleBillResponse billResponse = SingleBillResponse.fromJson(body);

        return ResultResponse.success(billResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<BillResultResponse>> removeBill(int id) async {
    try {
      final response = await APIService.instance.request(
          ApiUrls.removeBillUrl(id), DioMethod.delete,
          includeHeaders: true);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        BillResultResponse logoutResponse = BillResultResponse.fromJson(body);
        return ResultResponse.success(logoutResponse);
      } else if (response.statusCode == HttpStatus.unauthorized) {
        Map<String, dynamic> body = response.data;
        BillResultResponse logoutResponse = BillResultResponse.fromJson(body);
        return ResultResponse.success(logoutResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.data is Map<String, dynamic>) {
          String errorMessage =
              e.response!.data['message'] ?? 'Bir hata oluştu.';

          if (e.response?.statusCode == HttpStatus.unauthorized) {
            BillResultResponse logoutResponse =
                BillResultResponse.fromJson(e.response!.data);
            return ResultResponse.success(logoutResponse);
          }

          return ResultResponse.failure(errorMessage);
        }
      }
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<EducationInformationResponse>>
      getEducationInfo() async {
    try {
      final response = await APIService.instance
          .request(ApiUrls.getEducationInfo, DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        EducationInformationResponse educationInformationResponse =
            EducationInformationResponse.fromJson(body);

        return ResultResponse.success(educationInformationResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<FavoriteSchoolResponse>> getFavorites() async {
    try {
      final response = await APIService.instance
          .request(ApiUrls.getFavorites, DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        FavoriteSchoolResponse favoriteSchoolResponse =
            FavoriteSchoolResponse.fromJson(body);

        return ResultResponse.success(favoriteSchoolResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<FavoriteToggleResponse>> toggleFav(int id) async {
    try {
      final response = await APIService.instance
          .request(ApiUrls.toggleFavorite(id), DioMethod.post);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        FavoriteToggleResponse favoriteSchoolResponse =
            FavoriteToggleResponse.fromJson(body);

        return ResultResponse.success(favoriteSchoolResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<MobileHomeResponse>> getDashboard() async {
    try {
      final token = await getToken();
      final response = await APIService.instance.request(
        token != null ? ApiUrls.getHomePageWithLogin : ApiUrls.getHomePage,
        DioMethod.get,
        includeHeaders: token != null ? true : false,
      );
      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        MobileHomeResponse mobileHomeResponse = MobileHomeResponse.fromJson(body);

        return ResultResponse.success(mobileHomeResponse);
      } else {
        return ResultResponse.failure('API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      return ResultResponse.failure('Exception: $e');
    }
  }


  Future<ResultResponse<RequestCourseResponseModel>> courseRequest(
      CourseRequest request) async {
    try {
      final response = await APIService.instance.request(
          ApiUrls.courseRequestURL, param: request.toJson(), DioMethod.post);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        RequestCourseResponseModel responseModel =
            RequestCourseResponseModel.fromJson(body);

        return ResultResponse.success(responseModel);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      return ResultResponse.failure('Exception: $e');
    }
  }
}

const mailNotVerifiedFailure = "MailNotVerifiedFailure";
const genericErrorException = "Bir Hata Oluştu";

abstract class AppFailure {
  final String message;

  AppFailure(this.message);
}

class MailNotVerifiedFailure extends AppFailure {
  MailNotVerifiedFailure() : super('Mail adresiniz onaylanmadı');
}

class GenericFailure extends AppFailure {
  GenericFailure() : super('Bilinmeyen bir hata oluştu');
}
