class SingleBillResponse {
  bool? status;
  Data? data;

  SingleBillResponse({this.status, this.data});

  SingleBillResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? studentId;
  String? title;
  String? district;
  String? street;
  String? apartmentNo;
  String? flatNo;
  String? postalCode;
  int? cityId;
  bool? isDefault;

  Data(
      {this.id,
        this.studentId,
        this.title,
        this.district,
        this.street,
        this.apartmentNo,
        this.flatNo,
        this.postalCode,
        this.cityId,
        this.isDefault});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    title = json['title'];
    district = json['district'];
    street = json['street'];
    apartmentNo = json['apartment_no'];
    flatNo = json['flat_no'];
    postalCode = json['postal_code'];
    cityId = json['city_id'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['student_id'] = studentId;
    data['title'] = title;
    data['district'] = district;
    data['street'] = street;
    data['apartment_no'] = apartmentNo;
    data['flat_no'] = flatNo;
    data['postal_code'] = postalCode;
    data['city_id'] = cityId;
    data['is_default'] = isDefault;
    return data;
  }
}
