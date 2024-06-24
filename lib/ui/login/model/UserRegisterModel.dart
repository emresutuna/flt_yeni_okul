import 'package:yeni_okul/ui/login/UserRole.dart';

class UserRegisterModel {
  String id;
  String name;
  String surname;
  String email;
  String phone;
  String password;
  UserRole userRole;
  DateTime createdDate;
  int? companyCode;

  UserRegisterModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
    required this.password,
    required this.userRole,
    required this.createdDate,
    this.companyCode
  });
  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'surname': surname,
        'email': email,
        'phone': phone,
        'password': password,
        'userRole': userRole.label,
        'createdDate': createdDate,
        'companyCode': companyCode,
      };

}