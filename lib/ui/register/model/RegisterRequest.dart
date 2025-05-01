class RegisterRequest {
  String name;
  String surname;
  String email;
  String phone;
  String password;
  String birth_year;

  RegisterRequest({
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
    required this.password,
    required this.birth_year,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (name.isNotEmpty) data['name'] = name;
    if (surname.isNotEmpty) data['surname'] = surname;
    if (email.isNotEmpty) data['email'] = email;
    if (phone.isNotEmpty) data['phone'] = phone;
    if (password.isNotEmpty) data['password'] = password;
    if (birth_year.isNotEmpty) data['birth_year'] = birth_year;

    return data;
  }

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      password: json['password'] ?? '',
      birth_year: json['birth_year'] ?? '',
    );
  }
}
