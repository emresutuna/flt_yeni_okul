import 'package:baykurs/ui/payment/makePayment/model/AddressController.dart';
import 'package:baykurs/ui/payment/makePayment/model/PaymentBillService.dart';
import 'package:baykurs/ui/requestlesson/SelectAllCitiesPage.dart';
import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/widgets/PrimaryInputField.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../util/YOColors.dart';
import '../../../widgets/GreenPrimaryButton.dart';
import '../../requestlesson/AllCities.dart';
import '../../requestlesson/Region.dart';
import '../../requestlesson/SelectRegionPage.dart';

class PaymentBillPage extends StatefulWidget {
  const PaymentBillPage({super.key});

  @override
  State<PaymentBillPage> createState() => _PaymentBillPageState();
}

class _PaymentBillPageState extends State<PaymentBillPage> {
  final PaymentBillService _service = PaymentBillService();

  final AddressController controller = Get.put(AddressController());
  final ValueNotifier<List<Region>> regions = ValueNotifier([]);
  final ValueNotifier<List<AllCities>> provinces = ValueNotifier([]);
  Region? selectedRegion;
  AllCities? selectedProvince;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchRegions();
  }

  Future<void> _fetchRegions() async {
    regions.value = await _service.fetchRegions();
  }

  Future<void> _fetchProvinces(int regionId) async {
    final provinceList = await _service.fetchProvinces(regionId);

    if (provinceList.isNotEmpty) {
      provinces.value = provinceList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteAppBar("Fatura Adresi Ekle"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Faturanız e-posta olarak gönderilecektir. Faturanızı incelemek için mail adresinizi kontrol edin.",
              style: styleBlack14Regular,
            ),
            16.toHeight,
            PaymentInputField(
              controller: controller.billNameController,
              hintText: "Fatura Adı",
            ),
            12.toHeight,
            PaymentInputField(
              controller: controller.adController,
              hintText: "Ad",
            ),
            12.toHeight,
            PaymentInputField(
              controller: controller.soyadController,
              hintText: "Soyad",
            ),
            12.toHeight,

            /// 📌 TC Kimlik No
            PaymentInputField(
              controller: controller.tcKimlikController,
              hintText: "TC Kimlik No",
              maxLength: 11,
              keyboardType: TextInputType.number,
            ),
            12.toHeight,
            PaymentInputField(
              controller: controller.streetController,
              hintText: "Cadde/Sokak",
            ),
            12.toHeight,
            PaymentInputField(
              controller: controller.districtController,
              hintText: "Mahalle",
            ),
            12.toHeight,

            /// 📌 Adres
            Row(
              children: [
                /// 📌 Şehir Seçimi
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final selectedRegion = await Get.to(
                          () => SelectRegionPage(regions: regions.value));

                      if (selectedRegion != null) {
                        setState(() {
                          this.selectedRegion = selectedRegion;
                          print(this.selectedRegion?.id);
                          selectedProvince = null;
                          provinces.value = [];
                          controller.selectedRegion.value = this.selectedRegion;

                        });
                      }
                    },
                    child: AbsorbPointer(
                      // Kullanıcının input girmesini engellemek için
                      child: PaymentInputField(
                        controller: TextEditingController(
                            text: selectedRegion?.name ?? "İl Seç"),
                        hintText: "İl",
                        // Sağ tarafa ikon ekler
                      ),
                    ),
                  ),
                ),
                8.toWidth,

                /// 📌 İlçe Seçimi
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      await _fetchProvinces(selectedRegion?.id ?? 0);
                      if (selectedRegion == null) {
                        Get.snackbar("Uyarı", "Lütfen önce bir il seçin.",
                            colorText: Colors.white,
                            backgroundColor: Colors.red);
                        return;
                      }

                      final selectedDistrict = await Get.to(() =>
                          SelectAllCitiesPage(provinces: provinces.value));

                      if (selectedDistrict != null) {
                        setState(() {
                          selectedProvince = selectedDistrict;
                          controller.selectedProvince.value = selectedProvince;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      // Kullanıcının input girmesini engellemek için
                      child: PaymentInputField(
                        controller: TextEditingController(
                            text: selectedProvince?.name ?? "İlçe Seç"),
                        hintText: "İlçe",
                        // Sağ tarafa ikon ekler
                      ),
                    ),
                  ),
                ),
              ],
            ),

            12.toHeight,
            Row(
              children: [
                Expanded(
                  child: PaymentInputField(
                    controller: controller.apartmentNoController,
                    hintText: "Bina No",
                  ),
                ),
                8.toWidth,
                Expanded(
                  child: PaymentInputField(
                    controller: controller.flatNoController,
                    hintText: "Daire No",
                  ),
                ),
              ],
            ),
            12.toHeight,
            PaymentInputField(
              controller: controller.postalCodeController,
              hintText: "Posta Kodu",
            ),


            8.toHeight,
            Obx(
              () => CheckboxListTile(
                title: Text(
                  "Bu adresi varsayılan yap",
                  style: styleBlack14Regular,
                ),
                activeColor: Colors.green,
                value: controller.isDefaultAddress.value,
                onChanged: (bool? value) {
                  controller.isDefaultAddress.value = value ?? false;
                },
              ),
            ),
            8.toHeight,

            SizedBox(
              height: 50,
              width: double.maxFinite,
              child: GreenPrimaryButton(
                text: "Devam Et",
                onPress: () async {
                  if (controller.validateAndSubmit()) {
                    await controller.saveAddress();
                    Future.delayed(const Duration(milliseconds: 500), () {
                      Navigator.pop(context, controller.setupAddress());
                    });
                  }
                },
              ),
            ),
            20.toHeight
          ],
        ),
      ),
    );
  }
}
