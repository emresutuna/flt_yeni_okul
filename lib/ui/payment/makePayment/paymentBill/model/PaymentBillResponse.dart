class PaymentBillResponse {
  bool? status;
  List<BillList>? data;

  PaymentBillResponse({this.status, this.data});

  PaymentBillResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <BillList>[];
      json['data'].forEach((v) {
        data!.add(BillList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BillList {
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

  BillList(
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

  BillList.fromJson(Map<String, dynamic> json) {
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
