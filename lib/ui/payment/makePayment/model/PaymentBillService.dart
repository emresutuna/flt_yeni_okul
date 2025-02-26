import 'package:baykurs/ui/payment/makePayment/model/AddressModelRequest.dart';
import 'package:baykurs/ui/requestlesson/AllCities.dart';
import 'package:baykurs/util/SharedPrefHelper.dart';

import '../../../../service/apiUrls.dart';
import '../../../requestlesson/Region.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentBillService {
  Future<List<Region>> fetchRegions() async {
    final response = await http.get(Uri.parse(ApiUrls.getProvinceAll));

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

  Future<List<AllCities>> fetchProvinces(int regionId) async {
    final response =
        await http.get(Uri.parse(ApiUrls.getAllDistrictsAll(regionId)));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true) {
        return (responseData['data'] as List)
            .map((district) => AllCities.fromJson(district))
            .toList();
      }
    }
    return [];
  }

  Future<AddressResponse> submitAddress(
      AddressModelRequest addressModelRequest) async {
    try {
      String? token = await getToken(); // Token çek
      print("JSON: ${addressModelRequest.toJson()}");
      if (token == null) {
        print("HATA: Token alınamadı!"); // Log
        return AddressResponse(
          success: false,
          data: null,
          message: "Kullanıcı oturum açmamış. Token bulunamadı.",
        );
      }

      print("Token: $token"); // Log

      final response = await http.post(
        Uri.parse("https://api.bykurs.com.tr/api/v1/mobile/address"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "X-Requested-From": "baykursmobileapp"
        },
        body: jsonEncode(addressModelRequest.toJson()),
      );

      print("API Response Code: ${response.statusCode}"); // Log
      print("API Response Body: ${response.body}"); // Log

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AddressResponse.fromJson(responseData);
      } else {
        return AddressResponse(
          success: false,
          data: null,
          message:
              responseData["message"] ?? "Adres kaydedilirken bir hata oluştu.",
        );
      }
    } catch (e) {
      print("Bağlantı Hatası: $e"); // Log
      return AddressResponse(
        success: false,
        data: null,
        message: "Bağlantı hatası: $e",
      );
    }
  }
}

class AddressResponse {
  final bool success;
  final AddressData? data;
  final String message;

  AddressResponse({required this.success, this.data, required this.message});

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      success: json['status'] ?? false,
      data: json['data'] != null ? AddressData.fromJson(json['data']) : null,
      message: json['message'] ?? "İşlem tamamlandı",
    );
  }
}

class AddressData {
  final int studentId;
  final String title;
  final String district;
  final String street;
  final int apartmentNo;
  final int flatNo;
  final int postalCode;
  final int cityId;
  final bool isDefault;
  final int id;

  AddressData({
    required this.studentId,
    required this.title,
    required this.district,
    required this.street,
    required this.apartmentNo,
    required this.flatNo,
    required this.postalCode,
    required this.cityId,
    required this.isDefault,
    required this.id,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      studentId: json['student_id'] ?? 0,
      title: json['title'] ?? "",
      district: json['district'] ?? "",
      street: json['street'] ?? "",
      apartmentNo: int.tryParse(json['apartment_no'].toString()) ?? 0,
      flatNo: int.tryParse(json['flat_no'].toString()) ?? 0,
      postalCode: int.tryParse(json['postal_code'].toString()) ?? 0,
      cityId: json['city_id'] ?? 0,
      isDefault: json['is_default'] ?? false,
      id: json['id'] ?? 0,
    );
  }
}
