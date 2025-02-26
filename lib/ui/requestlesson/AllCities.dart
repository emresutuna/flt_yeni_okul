class AllCitiesResponse {
  bool? status;
  List<AllCities>? data;

  AllCitiesResponse({this.status, this.data});

  AllCitiesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AllCities>[];
      json['data'].forEach((v) {
        data!.add(new AllCities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllCities {
  int? id;
  int? provinceId;
  String? name;
  String? latitude;
  String? longitude;
  int? order;

  AllCities(
      {this.id,
        this.provinceId,
        this.name,
        this.latitude,
        this.longitude,
        this.order});

  AllCities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provinceId = json['province_id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['province_id'] = this.provinceId;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['order'] = this.order;
    return data;
  }
}
