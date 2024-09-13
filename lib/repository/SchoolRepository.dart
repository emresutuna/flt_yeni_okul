import 'dart:io';

import 'package:yeni_okul/ui/company/model/SchoolResponse.dart';

import '../service/APIService.dart';
import '../service/ResultResponse.dart';
import '../service/apiUrls.dart';

class SchoolRepository {
  Future<ResultResponse<SchoolResponse>> getSchool() async {
    try {
      final response = await APIService.instance
          .request(school, DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        SchoolResponse schoolResponse = SchoolResponse.fromJson(body);

        return ResultResponse.success(schoolResponse);
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