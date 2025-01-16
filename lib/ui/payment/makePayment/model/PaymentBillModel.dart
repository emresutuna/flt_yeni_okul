import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PaymentBillModel {
  String name;
  String surname;
  String tckn;
  String birthday;
  String email;
  String city;
  String province;
  String address;
  String billName;

  // Constructor with required fields
  PaymentBillModel({
    required this.name,
    required this.surname,
    required this.tckn,
    required this.birthday,
    required this.email,
    required this.city,
    required this.province,
    required this.address,
    required this.billName,
  });

  // JSON'dan nesne oluşturma
  PaymentBillModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        surname = json['surname'],
        tckn = json['tckn'],
        birthday = json['birthday'],
        email = json['email'],
        city = json['city'],
        province = json['province'],
        address = json['address'],
        billName = json['billName'];

  // Nesneyi JSON'a çevirme
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'tckn': tckn,
      'birthday': birthday,
      'email': email,
      'city': city,
      'province': province,
      'address': address,
      'billName': billName,
    };
  }

  // SharedPreferences'e kaydetme
  Future<void> saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(toJson());
    await prefs.setString('paymentBillModel', jsonString);
  }

  // SharedPreferences'den yükleme
  static Future<PaymentBillModel?> loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('paymentBillModel');
    if (jsonString == null) return null;
    final jsonMap = jsonDecode(jsonString);
    return PaymentBillModel.fromJson(jsonMap);
  }

  // SharedPreferences'den silme
  static Future<void> removeFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('paymentBillModel');
  }
}
