import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../util/YOColors.dart';
import '../../requestlesson/AllCities.dart';
import '../../requestlesson/Region.dart';
import '../../requestlesson/SelectRegionPage.dart';
import 'model/PaymentBillService.dart';

class SinglePaymentBillPage extends StatefulWidget {
  const SinglePaymentBillPage({super.key, required this.id});

  final int id;

  @override
  State<SinglePaymentBillPage> createState() => _SinglePaymentBillPageState();
}

class _SinglePaymentBillPageState extends State<SinglePaymentBillPage> {
  final TextEditingController billTitleController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController tcController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController buildingNoController = TextEditingController();
  final TextEditingController apartmentNoController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final PaymentBillService _service = PaymentBillService();

  final ValueNotifier<bool> isDefault = ValueNotifier(false);
  bool isSaveButtonActive = false;

  Map<String, dynamic> originalData = {};
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _fetchSingleBill(widget.id);
    _setupListeners();
  }

  void _setupListeners() {
    billTitleController.addListener(_checkIfChanged);
    nameController.addListener(_checkIfChanged);
    surnameController.addListener(_checkIfChanged);
    tcController.addListener(_checkIfChanged);
    streetController.addListener(_checkIfChanged);
    districtController.addListener(_checkIfChanged);
    buildingNoController.addListener(_checkIfChanged);
    apartmentNoController.addListener(_checkIfChanged);
    postalCodeController.addListener(_checkIfChanged);
    isDefault.addListener(_checkIfChanged);
  }

  Future<void> _fetchSingleBill(int id) async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    final result = await _service.getSinglePaymentBill(id);

    if (result.error==null && result.data != null) {
      final bill = result.data!.data;

      billTitleController.text = bill?.title ?? "";
      streetController.text = bill?.street ?? "";
      districtController.text = bill?.district ?? "";
      buildingNoController.text = bill?.apartmentNo ?? "";
      apartmentNoController.text = bill?.flatNo ?? "";
      postalCodeController.text = bill?.postalCode ?? "";
      isDefault.value = bill?.isDefault ?? false;

      originalData = _getCurrentFormData();
      _checkIfChanged();

      setState(() {
        isLoading = false;
        isError = false;
      });
    } else {
      setState(() {
        isLoading = false;
        isError = true; // hata var!
      });
    }
  }

  Map<String, dynamic> _getCurrentFormData() {
    return {
      "billTitle": billTitleController.text,
      "name": nameController.text,
      "surname": surnameController.text,
      "tc": tcController.text,
      "street": streetController.text,
      "district": districtController.text,
      "buildingNo": buildingNoController.text,
      "apartmentNo": apartmentNoController.text,
      "postalCode": postalCodeController.text,
      "isDefault": isDefault.value,
    };
  }

  void _checkIfChanged() {
    final currentData = _getCurrentFormData();
    final hasChanged = currentData.toString() != originalData.toString();
    if (isSaveButtonActive != hasChanged) {
      setState(() {
        isSaveButtonActive = hasChanged;
      });
    }
  }

  Future<void> _saveBill() async {
    final newData = _getCurrentFormData();
    print("Saved data: $newData");

    await Future.delayed(const Duration(seconds: 1));

    originalData = newData;
    _checkIfChanged();

    Get.snackbar("Başarılı", "Fatura bilgileri kaydedildi!",
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteAppBar("Fatura Bilgileri"),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isError
          ? _buildErrorView()
          : _buildFormView(),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Fatura adresi bulunamadı",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _fetchSingleBill(widget.id); // tekrar dene
            },
            child: const Text("Tekrar Dene"),
          )
        ],
      ),
    );
  }

  Widget _buildFormView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildInput("Fatura Adı", billTitleController,"Fatura Adı"),
          _buildInput("Ad", nameController,"Ad"),
          _buildInput("Soyad", surnameController,"Soyad"),
          _buildInput("TC Kimlik No", tcController,"TC Kimlik No", keyboardType: TextInputType.number),
          _buildInput("Cadde/Sokak", streetController,"Cadde/Sokak"),
          _buildInput("Mahalle", districtController,"Mahalle"),
          Row(
            children: [
              Expanded(child: _buildInput("Bina No", buildingNoController,"Bina No")),
              const SizedBox(width: 8),
              Expanded(child: _buildInput("Daire No", apartmentNoController,"Daire No")),
            ],
          ),
          _buildInput("Posta Kodu", postalCodeController,"Posta Kodu"),
          ValueListenableBuilder<bool>(
            valueListenable: isDefault,
            builder: (context, value, _) {
             return CheckboxListTile(
                title: Text(
                  "Bu adresi varsayılan yap",
                  style: styleBlack14Regular,
                ),
                activeColor: Colors.green,
               value: value,
               onChanged: (val) {
                 isDefault.value = val ?? false;
               },
              );
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: isSaveButtonActive ? _saveBill : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isSaveButtonActive ? color3 : Colors.grey,
              ),
              child: const Text("Kaydet"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller,String hintText, {TextInputType? keyboardType, IconData? prefixIcon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          labelText: hintText,
          counterText: '',
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: paymentBorder),
          ),
          prefixIcon:
          prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,
        ),
      ),
    );
  }
}
