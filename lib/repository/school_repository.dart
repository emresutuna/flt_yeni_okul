import 'dart:io';
import 'package:baykurs/ui/company/model/school_filter.dart';
import 'package:baykurs/util/SharedPrefHelper.dart';
import '../service/api_service.dart';
import '../service/result_response.dart';
import '../service/api_urls.dart';
import '../ui/company/model/school_response.dart';
import '../ui/companyDetail/model/school_detail_response.dart';
import '../ui/favoriteschool/model/favorite_toggle_response.dart';

class SchoolRepository {
  Future<ResultResponse<SchoolResponse>> getSchool() async {
    try {
      final token = await getToken();
      final response = await APIService.instance.request(
          token != null ? ApiUrls.getSchoolWithLogin : ApiUrls.school,
          DioMethod.get,
          includeHeaders: token != null ? true : false);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        SchoolResponse schoolResponse = SchoolResponse.fromJson(body);

        return ResultResponse.success(schoolResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<SchoolResponse>> getSchoolBySearch(
       SchoolFilter filter) async {
    try {
      final response = await APIService.instance
          .request(buildUrlWithFilter(ApiUrls.school,filter), DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        SchoolResponse schoolResponse = SchoolResponse.fromJson(body);

        return ResultResponse.success(schoolResponse);
      } else {
        return ResultResponse.failure(
            'API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      return ResultResponse.failure('Exception: $e');
    }
  }

  Future<ResultResponse<SchoolDetailResponse>> getSchoolById(
      int schoolId) async {
    try {
      final response = await APIService.instance
          .request('${ApiUrls.school}/$schoolId', DioMethod.get);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        SchoolDetailResponse schoolResponse =
            SchoolDetailResponse.fromJson(body);

        return ResultResponse.success(schoolResponse);
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
}
