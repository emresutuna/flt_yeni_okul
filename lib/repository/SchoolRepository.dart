import 'dart:io';


import '../service/APIService.dart';
import '../service/ResultResponse.dart';
import '../service/apiUrls.dart';
import '../ui/company/model/SchoolResponse.dart';
import '../ui/companyDetail/model/SchoolDetailResponse.dart';

class SchoolRepository {
  Future<ResultResponse<SchoolResponse>> getSchool() async {
    try {
      final response = await APIService.instance
          .request(ApiUrls.school, DioMethod.get);

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
  Future<ResultResponse<SchoolDetailResponse>> getSchoolById(int schoolId) async {
    try {
      final response = await APIService.instance
          .request('${ApiUrls.schoolDetail}/$schoolId', DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        SchoolDetailResponse schoolResponse = SchoolDetailResponse.fromJson(body);

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