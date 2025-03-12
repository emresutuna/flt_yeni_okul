class AddressModelRequest {
  String title;
  String district;
  String street;
  String apartmentNo;
  String flatNo;
  String postalCode;
  int cityId;
  bool isDefault;

  AddressModelRequest({
    required this.title,
    required this.district,
    required this.street,
    required this.apartmentNo,
    required this.flatNo,
    required this.postalCode,
    required this.cityId,
    required this.isDefault,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (title.isNotEmpty) data["title"] = title;
    if (district.isNotEmpty) data["district"] = district;
    if (street.isNotEmpty) data["street"] = street;
    if (apartmentNo.isNotEmpty) data["apartment_no"] = apartmentNo;
    if (flatNo.isNotEmpty) data["flat_no"] = flatNo;
    if (postalCode.isNotEmpty) data["postal_code"] = postalCode;

    if (cityId != null && cityId != 0) {
      data["city_id"] = cityId;
    }

    if (isDefault == true) {
      data["is_default"] = isDefault;
    }

    return data;
  }

}
