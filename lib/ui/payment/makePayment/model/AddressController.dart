import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baykurs/ui/payment/makePayment/model/AddressModelRequest.dart';
import 'package:baykurs/ui/requestlesson/region.dart';
import 'package:baykurs/ui/requestlesson/all_cities.dart';
import 'package:baykurs/ui/payment/makePayment/model/PaymentBillService.dart';

class AddressController extends GetxController {
  final PaymentBillService _service = PaymentBillService();

  final TextEditingController billNameController = TextEditingController();
  final TextEditingController adController = TextEditingController();
  final TextEditingController soyadController = TextEditingController();
  final TextEditingController tcKimlikController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController apartmentNoController = TextEditingController();
  final TextEditingController flatNoController = TextEditingController();
  final TextEditingController streetController = TextEditingController(); // Cadde/Sokak
  final TextEditingController districtController = TextEditingController(); // Mahalle
  final int? selectedCityId = null;

  Rx<Region?> selectedRegion = Rx<Region?>(null);
  Rx<AllCities?> selectedProvince = Rx<AllCities?>(null);

  final RxList<Region> regions = <Region>[].obs;
  final RxList<AllCities> provinces = <AllCities>[].obs;

  RxBool isDefaultAddress = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRegions();
  }

  Future<void> fetchRegions() async {
    regions.value = await _service.fetchRegions();
  }

  Future<void> fetchProvinces(int regionId) async {
    final provinceList = await _service.fetchProvinces(regionId);
    if (provinceList.isNotEmpty) {
      provinces.value = provinceList;
    }
  }

  void clearAllFields() {
    billNameController.clear();
    adController.clear();
    soyadController.clear();
    tcKimlikController.clear();
    addressController.clear();
    postalCodeController.clear();
    apartmentNoController.clear();
    flatNoController.clear();
    streetController.clear();
    districtController.clear();
    selectedRegion.value = null;
    selectedProvince.value = null;
    isDefaultAddress.value = false;
  }

  AddressModelRequest setupAddress() {
    return AddressModelRequest(
      title: billNameController.text,
      district: districtController.text, // Mahalle
      street: streetController.text, // Cadde/Sokak
      apartmentNo: apartmentNoController.text ?? "",
      flatNo: flatNoController.text ?? "",
      postalCode: postalCodeController.text ?? "",
      cityId: selectedProvince.value?.id ?? 0,
      isDefault: isDefaultAddress.value ? true : false,
    );
  }
  Future<void> saveAddress() async {

    AddressModelRequest addressModel = setupAddress();
    PaymentBillService addressService = PaymentBillService();

    AddressResponse response = await addressService.submitAddress(addressModel);
    if (response.success) {
      Get.snackbar(
        "Başarılı",
        response.message,
        colorText: Colors.white,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
      );
      clearAllFields();

    } else {
      Get.snackbar(
        "Hata",
        response.message,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  bool validateAndSubmit() {
    String billName = billNameController.text.trim();
    String ad = adController.text.trim();
    String soyad = soyadController.text.trim();
    String tcKimlik = tcKimlikController.text.trim();
    String address = addressController.text.trim();
    String street = streetController.text.trim();
    String district = districtController.text.trim();
    String postalCode = postalCodeController.text.trim();
    String apartmentNo = apartmentNoController.text.trim();
    String flatNo = flatNoController.text.trim();

    String errorMessage = '';

    // Alanlar boşsa uyarı ver
    if (billName.isEmpty &&
        ad.isEmpty &&
        soyad.isEmpty &&
        tcKimlik.isEmpty &&
        street.isEmpty &&
        district.isEmpty &&
        postalCode.isEmpty &&
        apartmentNo.isEmpty &&
        flatNo.isEmpty &&
        selectedRegion.value == null &&
        selectedProvince.value == null) {
      Get.snackbar(
        "Hata",
        "Lütfen tüm alanları doldurunuz.",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    if (billName.isEmpty) {
      errorMessage += 'Fatura Adı boş olmamalı. ';
    }
    if (ad.isEmpty || ad.length < 2) {
      errorMessage += 'Ad en az 2 karakter olmalı. ';
    }
    if (soyad.isEmpty) {
      errorMessage += 'Soyad boş olmamalı. ';
    }
    if (tcKimlik.isEmpty ||
        tcKimlik.length != 11 ||
        !RegExp(r'^\d+$').hasMatch(tcKimlik)) {
      errorMessage += 'Geçersiz TC Kimlik No. ';
    }

    if (street.isEmpty || street.length < 2) {
      errorMessage += 'Cadde/Sokak en az 2 karakter olmalı. ';
    }
    if (district.isEmpty || district.length < 2) {
      errorMessage += 'Mahalle en az 2 karakter olmalı. ';
    }
    if (apartmentNo.isEmpty || int.tryParse(apartmentNo) == null) {
      errorMessage += 'Geçersiz bina numarası. ';
    }
    if (flatNo.isEmpty || int.tryParse(flatNo) == null) {
      errorMessage += 'Geçersiz daire numarası. ';
    }
    if (postalCode.isEmpty || postalCode.length < 4) {
      errorMessage += 'Geçersiz posta kodu. ';
    }
    if (selectedRegion.value == null) {
      errorMessage += 'Lütfen bir il seçiniz. ';
    }
    if (selectedProvince.value == null) {
      errorMessage += 'Lütfen bir ilçe seçiniz. ';
    }

    // Hata mesajı varsa göster ve işlemi iptal et
    if (errorMessage.isNotEmpty) {
      Get.snackbar(
        "Hata",
        errorMessage.trim(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return true;
  }
}
