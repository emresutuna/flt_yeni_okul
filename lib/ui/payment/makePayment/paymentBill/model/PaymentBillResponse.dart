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
  City? city;

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
      this.isDefault,
      this.city});

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
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
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
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class City {
  int? id;
  String? name;
  int? provinceId;
  Province? province;

  City({this.id, this.name, this.provinceId, this.province});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    provinceId = json['province_id'];
    province =
        json['province'] != null ? Province.fromJson(json['province']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['province_id'] = provinceId;
    if (province != null) {
      data['province'] = province!.toJson();
    }

    return data;
  }
}

class Province {
  int? id;
  String? name;

  Province({this.id, this.name});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
