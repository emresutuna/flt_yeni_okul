import 'dart:io';

import 'package:baykurs/ui/course/model/CourseTypeEnum.dart';

import '../service/api_service.dart';
import '../service/result_response.dart';
import '../ui/payment/model/PaymentResponse.dart';

class PaymentRepository {
  Future<ResultResponse<PaymentResponse>> postBuyCourse(
      int courseId, CourseTypeEnum courseType) async {
    try {
      final response = await APIService.instance.request(
        buyCourse(courseId, courseType),
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
      return ResultResponse.failure('Exception: $e');
    }
  }
}

String buyCourse(int id, CourseTypeEnum courseType) {
  switch (courseType) {
    case CourseTypeEnum.COURSE_BUNDLE:
      return "/mobile/courseBundle/$id/buy";
    case CourseTypeEnum.COURSE_COACH:
      return "/mobile/courseCoach/$id/buy";
    case CourseTypeEnum.COURSE:
    default:
      return "/mobile/course/$id/buy";
  }
}
