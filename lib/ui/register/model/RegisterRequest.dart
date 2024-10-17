class RegisterRequest {
  String name;
  String tckn;
  String email;
  String phone;
  String password;

  RegisterRequest({
    required this.name,
    required this.tckn,
    required this.email,
    required this.phone,
    required this.password,
  });

  // JSON'e çevirme fonksiyonu
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tckn': tckn,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      name: json['name'],
      tckn: json['tckn'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
    );
  }
}
