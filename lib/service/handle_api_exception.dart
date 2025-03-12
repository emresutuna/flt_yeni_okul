import 'package:dio/dio.dart';

import 'result_response.dart';

ResultResponse<T> handleDioException<T>(DioException e) {
  if (e.response != null && e.response!.data is Map<String, dynamic>) {
    String errorMessage = e.response!.data['message'] ?? 'Bir hata oluştu.';
    switch (e.response?.statusCode) {
      case 401:
        return ResultResponse.failure('Yetkilendirme hatası: $errorMessage');
      case 403:
        return ResultResponse.failure('Erişim reddedildi: $errorMessage');
      case 404:
        return ResultResponse.failure('Kaynak bulunamadı: $errorMessage');
      case 500:
        return ResultResponse.failure('Sunucu hatası: $errorMessage');
      default:
        return ResultResponse.failure('Bir hata oluştu: $errorMessage');
    }
  }
  return ResultResponse.failure('Bilinmeyen bir hata oluştu: ${e.message}');
}
String handleGeneralException(Object e) {
  if (e is DioException) {
    if (e.response != null && e.response!.data is Map<String, dynamic>) {
      String errorMessage = e.response!.data['message'] ?? 'Bir hata oluştu.';
      switch (e.response?.statusCode) {
        case 401:
          return 'Yetkilendirme hatası: $errorMessage';
        case 403:
          return 'Erişim reddedildi: $errorMessage';
        case 404:
          return 'Kaynak bulunamadı: $errorMessage';
        case 500:
          return 'Sunucu hatası: $errorMessage';
        default:
          return 'Bir hata oluştu: $errorMessage';
      }
    }
    return 'Bilinmeyen bir hata oluştu: ${e.message}';
  } else if (e is Exception) {
    return 'Bir hata oluştu: ${e.toString()}';
  }
  return 'Beklenmeyen bir hata oluştu.';
}
