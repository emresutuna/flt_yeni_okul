class PriceModel {
  bool? status;
  Data? data;

  PriceModel({this.status, this.data});

  PriceModel.fromJson(Map<String, dynamic> json) {
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
  String? maxPrice;
  int? courseType;

  Data({this.maxPrice, this.courseType});

  Data.fromJson(Map<String, dynamic> json) {
    maxPrice = json['max_price'];
    courseType = json['course_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['max_price'] = maxPrice;
    data['course_type'] = courseType;
    return data;
  }
}
