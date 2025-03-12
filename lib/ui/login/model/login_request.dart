class LoginRequest {
  String email;
  String password;
  int remember;

  LoginRequest({required this.email, required this.password, required this.remember});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['remember'] = remember;
    return data;
  }
}