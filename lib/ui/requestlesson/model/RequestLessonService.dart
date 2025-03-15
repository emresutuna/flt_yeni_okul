import 'dart:convert';
import 'package:baykurs/util/YOColors.dart';
import 'package:baykurs/util/mail_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../service/api_urls.dart';
import '../../../util/LessonExtension.dart';
import '../../../util/SharedPrefHelper.dart';
import 'CourseRequestSchool.dart';
import '../region.dart';

class RequestLessonService {
  Future<List<Region>> fetchRegions() async {
    final response = await http.get(
      Uri.parse(ApiUrls.getProvince),
      headers: {
        "Content-Type": "application/json",
        "X-Requested-From": "baykursmobileapp"
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true) {
        return (responseData['data'] as List)
            .map((region) => Region.fromJson(region))
            .toList();
      }
    }
    return [];
  }

  Future<List<Province>> fetchProvinces(int regionId) async {
    final response = await http.get(
      Uri.parse(ApiUrls.getAllDistricts(regionId)),
      headers: {
        "Content-Type": "application/json",
        "X-Requested-From": "baykursmobileapp"
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true) {
        return (responseData['data'] as List)
            .map((district) => Province.fromJson(district))
            .toList();
      }
    }
    return [];
  }

  Future<List<CourseRequestSchool>> fetchSchools(
    BuildContext context,
    int regionId,
    int provinceId,
  ) async {
    final String? token = await getToken();
    final url = (regionId == 0)
        ? ApiUrls.getCourseRequestSchools
        : ApiUrls.getCourseRequestSchoolsById(regionId, provinceId);

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'X-Requested-From': 'baykursmobileapp',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == true) {
          return (responseData['data'] as List)
              .map((school) => CourseRequestSchool.fromJson(school))
              .toList();
        } else {
          throw Exception("Veri alınamadı");
        }
      } else if (response.statusCode == 403) {
        showMailDialog(context: context);

        throw Exception("Mail onaylanmadı");
      } else {
        throw Exception("Bir hata oluştu: ${response.statusCode}");
      }
    } catch (e) {
      rethrow; // Hatayı olduğu gibi yukarı fırlat
    }
  }

  List<BranchTopic> getBranchTopicsByClass(
      Branches branch, ClassTypes classType) {
    return filterBranchTopics(classLevelBranches,
        classLevel: classType, branch: branch);
  }
}
