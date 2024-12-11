import 'dart:io';

import 'package:baykurs/ui/course/model/CourseFilter.dart';
import 'package:baykurs/ui/teacherCoach/model/CourseCoachResponse.dart';
import 'package:baykurs/ui/teacherCoachDetail/model/CourseCoachDetailResponse.dart';

import '../service/APIService.dart';
import '../service/ResultResponse.dart';
import '../service/apiUrls.dart';
import '../ui/course/model/CourseModel.dart';
import '../ui/coursedetail/model/CourseDetailResponseModel.dart';

class LectureRepository {
  Future<ResultResponse<CourseResponseModel>> getLessons() async {
    try {
      final response =
          await APIService.instance.request(ApiUrls.getCourses, DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        CourseResponseModel lessonResponse = CourseResponseModel.fromJson(body);

        return ResultResponse.success(lessonResponse);
      } else if (response.statusCode == HttpStatus.unauthorized) {
        // Unauthorized - redirect to login page
        return ResultResponse.failure(
            'Unauthorized: Redirecting to login page');
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<CourseCoachResponse>> getCourseCoach() async {
    try {
      final response = await APIService.instance
          .request(ApiUrls.getCourseCoaches, DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        CourseCoachResponse courseCoachResponse =
            CourseCoachResponse.fromJson(body);

        return ResultResponse.success(courseCoachResponse);
      } else if (response.statusCode == HttpStatus.unauthorized) {
        // Unauthorized - redirect to login page
        return ResultResponse.failure(
            'Unauthorized: Redirecting to login page');
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<CourseCoachDetailResponse>> getCourseCoachDetail(
      int id) async {
    try {
      final response = await APIService.instance
          .request(ApiUrls.courseCoachDetail(id), DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        CourseCoachDetailResponse courseCoachResponse =
            CourseCoachDetailResponse.fromJson(body);

        return ResultResponse.success(courseCoachResponse);
      } else if (response.statusCode == HttpStatus.unauthorized) {
        // Unauthorized - redirect to login page
        return ResultResponse.failure(
            'Unauthorized: Redirecting to login page');
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<CourseCoachResponse>> getCourseCoachByFilter(
      CourseFilter filter) async {
    try {
      final response = await APIService.instance.request(
          buildUrlWithFilter(ApiUrls.getCourseCoaches, filter), DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        CourseCoachResponse courseCoachResponse =
            CourseCoachResponse.fromJson(body);

        return ResultResponse.success(courseCoachResponse);
      } else if (response.statusCode == HttpStatus.unauthorized) {
        // Unauthorized - redirect to login page
        return ResultResponse.failure(
            'Unauthorized: Redirecting to login page');
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<CourseResponseModel>> getCourseByFilter(
      CourseFilter filter) async {
    try {
      final response = await APIService.instance.request(
          buildUrlWithFilter(ApiUrls.getCourses, filter), DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        CourseResponseModel lessonResponse = CourseResponseModel.fromJson(body);

        return ResultResponse.success(lessonResponse);
      } else if (response.statusCode == HttpStatus.unauthorized) {
        // Unauthorized - redirect to login page
        return ResultResponse.failure(
            'Unauthorized: Redirecting to login page');
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<CourseDetailResponseModel>> getCourseById(
      int courseId) async {
    try {
      final response = await APIService.instance.request(
          '${ApiUrls.getCoursesById}/$courseId${ApiUrls.getCoursesById2}',
          DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        CourseDetailResponseModel courseResponseModel =
            CourseDetailResponseModel.fromJson(body);

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
