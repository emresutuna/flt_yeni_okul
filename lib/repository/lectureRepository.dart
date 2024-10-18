import 'dart:io';


import '../service/APIService.dart';
import '../service/ResultResponse.dart';
import '../service/apiUrls.dart';
import '../ui/companyDetail/model/SchoolDetailResponse.dart';
import '../ui/course/model/CourseModel.dart';
import '../ui/coursedetail/model/CourseDetailResponseModel.dart';

class LectureRepository {
  Future<ResultResponse<CourseResponseModel>> getLessons() async {
    try {
      final response = await APIService.instance
          .request(getCourses, DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        CourseResponseModel lessonResponse = CourseResponseModel.fromJson(body);

        return ResultResponse.success(lessonResponse);
      }
      else if (response.statusCode == HttpStatus.unauthorized) {
        // Unauthorized - redirect to login page
        return ResultResponse.failure('Unauthorized: Redirecting to login page');
      }
      else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      return ResultResponse.failure('Exception: $e');
    }
  }
  Future<ResultResponse<CourseDetailResponseModel>> getCourseById(int courseId) async {
    try {
      final response = await APIService.instance
          .request('$getCoursesById/$courseId$getCoursesById2', DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        CourseDetailResponseModel courseResponseModel = CourseDetailResponseModel.fromJson(body);

        return ResultResponse.success(courseResponseModel);
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