import 'dart:io';
import 'package:baykurs/ui/course/model/course_filter.dart';
import 'package:baykurs/ui/course/model/course_type_enum.dart';
import 'package:baykurs/ui/courseBundle/model/course_bundle_response.dart';
import 'package:baykurs/ui/filter/model/PriceModel.dart';
import 'package:baykurs/ui/teacherCoach/model/CourseCoachResponse.dart';
import 'package:baykurs/ui/teacherCoachDetail/model/CourseCoachDetailResponse.dart';
import '../service/api_service.dart';
import '../service/result_response.dart';
import '../service/api_urls.dart';
import '../ui/course/model/course_model.dart';
import '../ui/courseBundleDetail/model/course_bundle_detail_response.dart';
import '../ui/coursedetail/model/course_detail_response_model.dart';

class LectureRepository {
  Future<ResultResponse<CourseResponse>> getLessons() async {
    try {
      final response =
          await APIService.instance.request(ApiUrls.getCourses, DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        CourseResponse lessonResponse = CourseResponse.fromJson(body);

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
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<CourseBundleResponse>> getCourseBundle() async {
    try {
      final response = await APIService.instance
          .request(ApiUrls.getCourseBundle, DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        CourseBundleResponse courseBundleResponse =
            CourseBundleResponse.fromJson(body);

        return ResultResponse.success(courseBundleResponse);
      } else if (response.statusCode == HttpStatus.unauthorized) {
        // Unauthorized - redirect to login page
        return ResultResponse.failure(
            'Unauthorized: Redirecting to login page');
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
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
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<CourseBundleResponse>> getCourseBundleWithFilter(
      CourseFilter filter) async {
    try {
      final response = await APIService.instance.request(
          buildUrlWithFilter(ApiUrls.getCourseBundle, filter), DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        CourseBundleResponse courseCoachResponse =
            CourseBundleResponse.fromJson(body);

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
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<CourseResponse>> getCourseByFilter(
      CourseFilter filter) async {
    try {
      final response = await APIService.instance.request(
          buildUrlWithFilter(ApiUrls.getCourses, filter), DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        CourseResponse lessonResponse = CourseResponse.fromJson(body);

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
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<CourseDetailResponse>> getCourseById(
      int courseId) async {
    try {
      final response = await APIService.instance
          .request(ApiUrls.getCoursesById(courseId), DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        CourseDetailResponse courseResponseModel =
            CourseDetailResponse.fromJson(body);

        return ResultResponse.success(courseResponseModel);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      return ResultResponse.failure('Exception: $e');
    }
  }
  Future<ResultResponse<CourseDetailResponse>> getIncomingCourseById(
      int courseId) async {
    try {
      final response = await APIService.instance
          .request(ApiUrls.getIncomingCoursesById(courseId), DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        CourseDetailResponse courseResponseModel =
        CourseDetailResponse.fromJson(body);

        return ResultResponse.success(courseResponseModel);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<CourseBundleDetailResponse>> getCourseBundleById(
      int courseId) async {
    try {
      final response = await APIService.instance
          .request(ApiUrls.getCourseBundleById(courseId), DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        CourseBundleDetailResponse courseResponseModel =
            CourseBundleDetailResponse.fromJson(body);

        return ResultResponse.success(courseResponseModel);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<PriceModel>> getMaxPrice(
      CourseTypeEnum courseType) async {
    try {
      final response = await APIService.instance
          .request(UrlHelper.getMaxPriceUrl(courseType), DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        PriceModel priceModel = PriceModel.fromJson(body);

        return ResultResponse.success(priceModel);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      return ResultResponse.failure('Exception: $e');
    }
  }
}
