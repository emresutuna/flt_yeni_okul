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
    return {
      "title": title,
      "district": district,
      "street": street,
      "apartment_no": apartmentNo,
      "flat_no": flatNo,
      "postal_code": postalCode,
      "city_id": cityId,
      "is_default": isDefault,
    };
  }
}
