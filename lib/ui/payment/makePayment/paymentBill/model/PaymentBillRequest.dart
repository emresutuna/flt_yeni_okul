class PaymentBillRequest {
  final String title;
  final String district;
  final String street;
  final int apartmentNo;
  final int flatNo;
  final String postalCode;
  final int cityId;
  final int isDefault;

  PaymentBillRequest({
    required this.title,
    required this.district,
    required this.street,
    required this.apartmentNo,
    required this.flatNo,
    required this.postalCode,
    required this.cityId,
    required this.isDefault,
  });

  // JSON'a dönüştürme fonksiyonu
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

  // JSON'dan nesneye dönüştürme fonksiyonu
  factory PaymentBillRequest.fromJson(Map<String, dynamic> json) {
    return PaymentBillRequest(
      title: json["title"] ?? "",
      district: json["district"] ?? "",
      street: json["street"] ?? "",
      apartmentNo: json["apartment_no"] ?? 0,
      flatNo: json["flat_no"] ?? 0,
      postalCode: json["postal_code"] ?? "",
      cityId: json["city_id"] ?? 0,
      isDefault: json["is_default"] ?? 0,
    );
  }
}
