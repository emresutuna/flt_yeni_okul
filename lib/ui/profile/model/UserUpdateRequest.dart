class UserUpdateRequestModel {
  String? name;
  String? phone;
  String? password;
  String? email;

  UserUpdateRequestModel({this.name, this.phone, this.password, this.email});

  UserUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    password = json['password'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (phone != null) data['phone'] = phone;
    if (password != null) data['password'] = password;
    if (email != null) data['email'] = email;
    return data;
  }
}