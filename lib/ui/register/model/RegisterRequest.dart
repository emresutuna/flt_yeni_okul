class RegisterRequest {
  String name;
  String surname;
  String email;
  String phone;
  String password;

  RegisterRequest({
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
    );
  }
}
