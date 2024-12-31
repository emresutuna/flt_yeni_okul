import 'package:baykurs/ui/filter/FilterProvince.dart';
import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';
import '../../widgets/PrimaryInputField.dart';
import '../company/model/SchoolFilter.dart';
import '../requestlesson/Region.dart';
import 'FilterRegion.dart';

class FilterSchool extends StatefulWidget {
  final SchoolFilter currentFilter;

  const FilterSchool({super.key, required this.currentFilter});

  @override
  State<FilterSchool> createState() => _FilterSchoolState();
}

class _FilterSchoolState extends State<FilterSchool> {
  final TextEditingController ilController = TextEditingController();
  final TextEditingController ilceController = TextEditingController();
  late SchoolFilter schoolFilter;

  Region? selectedCity;
  Province? selectedProvince;

  @override
  void initState() {
    super.initState();
    schoolFilter = widget.currentFilter;
    currentFilterController();
  }

  void currentFilterController() {
    if (schoolFilter.cityName != null) {
      ilceController.text = schoolFilter.cityName!;
    }
    if (schoolFilter.provinceName != null) {
      ilController.text = schoolFilter.provinceName!;
    }
    selectedCity = schoolFilter.cityId != null
        ? Region(id: schoolFilter.cityId!, name: schoolFilter.cityName ?? "")
        : null;
    selectedProvince = schoolFilter.provinceId != null
        ? Province(
            id: schoolFilter.provinceId!, name: schoolFilter.provinceName ?? "")
        : null;
  }

  void clearFilters() {
    setState(() {
      ilController.clear();
      ilceController.clear();
      schoolFilter = SchoolFilter();
      selectedCity = null;
      selectedProvince = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0.0,
        centerTitle: false,
        elevation: 10,
        title: Text(
          "Filtrele",
          style: styleBlack16Bold,
        ),
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: clearFilters,
            child: Text(
              "Temizle",
              style: styleBlack14Bold.copyWith(
                color: Colors.redAccent,
                decoration: TextDecoration.underline,
                decorationColor: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "İl",
                        style: styleBlack16Bold,
                      ),
                      16.toHeight,
                      _buildTextField("İl Seç", ilController, context),
                      16.toHeight,
                      Text(
                        "İlçe",
                        style: styleBlack16Bold,
                      ),
                      16.toHeight,
                      _buildTextFieldProvince(
                          "İlçe Seç", ilceController, context),
                    ],
                  ),
                ),
              ),
            ),
            _buildFilterButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldProvince(
      String hint, TextEditingController controller, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (selectedCity != null) {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilterProvince(
                selectedCityId: selectedCity?.id ?? 0,
                initialSelectedProvince: selectedProvince,
              ),
            ),
          );
          if (result != null && result is Province) {
            setState(() {
              selectedProvince = result;
              controller.text = result.name;
            });
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Lütfen önce bir il seçin.")),
          );
          return;
        }
      },
      child: AbsorbPointer(
        child: PrimaryInputField(
          controller: controller,
          hintText: hint,
        ),
      ),
    );
  }

  Widget _buildTextField(
      String hint, TextEditingController controller, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FilterRegion(initialSelectedCity: selectedCity),
          ),
        );

        if (result != null && result is Region) {
          setState(() {
            selectedCity = result;
            controller.text = result.name;
          });
        }
      },
      child: AbsorbPointer(
        child: PrimaryInputField(
          controller: controller,
          hintText: hint,
        ),
      ),
    );
  }

  Widget _buildFilterButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
          onPressed: () {
            final updatedFilter = schoolFilter.copyWith(
              cityName:
                  ilceController.text.isNotEmpty ? ilceController.text : null,
              provinceName:
                  ilController.text.isNotEmpty ? ilController.text : null,
              provinceId: selectedProvince?.id,
              cityId: selectedCity?.id,
            );
            Navigator.pop(context, updatedFilter);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color5,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: 8.circularRadius, topRight: 8.circularRadius)),
          ),
          child: Text(
            "Filtrele",
            style: styleWhite14Bold,
          )),
    );
  }
}
