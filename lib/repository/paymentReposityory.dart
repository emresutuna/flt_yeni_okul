import 'dart:io';

import 'package:baykurs/service/apiUrls.dart';

import '../service/APIService.dart';
import '../service/ResultResponse.dart';
import '../ui/payment/model/PaymentResponse.dart';

class PaymentRepository {
  Future<ResultResponse<PaymentResponse>> postBuyCourse(int courseId) async {
    try {
      final response = await APIService.instance.request(
        ApiUrls.buyCourse(courseId),
        DioMethod.post,
      );

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        PaymentResponse paymentResponse = PaymentResponse.fromJson(body);

        return ResultResponse.success(paymentResponse);
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
