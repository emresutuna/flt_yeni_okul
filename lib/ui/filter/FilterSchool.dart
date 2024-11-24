import 'package:baykurs/ui/filter/FilterProvince.dart';
import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';

import '../requestlesson/Region.dart';
import 'FilterRegion.dart';

class FilterSchool extends StatefulWidget {
  const FilterSchool({super.key});

  @override
  State<FilterSchool> createState() => _FilterSchoolState();
}

class _FilterSchoolState extends State<FilterSchool> {
  final TextEditingController ilController = TextEditingController();
  final TextEditingController ilceController = TextEditingController();

  Region? selectedCity;
  Province? selectedProvince;

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
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Temizle işlemi
            },
            child: Text(
              "Temizle",
              style: styleBlack14Bold.copyWith(
                  color: Colors.redAccent,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.redAccent),
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
                      const Text(
                          "Herhangi birini seçerek kullanıcı bilgilerini güncelleyebilirsiniz"),
                      16.toHeight,
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
        }
      },
      child: AbsorbPointer(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
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
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
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
            // Filtrele işlemi
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
