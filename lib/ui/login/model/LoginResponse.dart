class LoginResponse {
  String? token;

  LoginResponse({this.token});

  Map<String, dynamic> toJson() => {'token': token};
  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }
}
