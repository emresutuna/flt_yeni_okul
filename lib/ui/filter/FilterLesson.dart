import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';

import '../../util/LessonExtension.dart';
import '../priceFilter/PriceFilterPage.dart';

class FilterLesson extends StatelessWidget {
  final TextEditingController konuController = TextEditingController();
  final TextEditingController ilController = TextEditingController();
  final TextEditingController ilceController = TextEditingController();

  FilterLesson({super.key});

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
                      Text("Fiyat",style: styleBlack18Bold,),
                      16.toHeight,

                      PriceFilter(
                        minLimit: 0,
                        maxLimit: 50000,
                        onApply: (minValue, maxValue) {
                          print('Güncellenen Min Fiyat: $minValue TL');
                          print('Güncellenen Max Fiyat: $maxValue TL');
                        },
                      ),
                      16.toHeight,
                      Text("Branş",style: styleBlack18Bold,),
                      16.toHeight,
                      _buildBranches(),
                      16.toHeight,
                      Text("Konu",style: styleBlack18Bold,),
                      16.toHeight,
                      _buildTextField("Konu Seç", konuController),
                      16.toHeight,

                      Text("İl",style: styleBlack18Bold,),
                      16.toHeight,
                      _buildTextField("İl Seç", ilController),
                      16.toHeight,
                      Text("İl",style: styleBlack18Bold,),
                      16.toHeight,

                      _buildTextField("İlçe Seç", ilceController),
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

  Widget _buildBranches() {
    final branches = BranchesExtension.allBranches;

    // Seçim durumunu takip etmek için bir liste
    final List<bool> isSelected = List.generate(branches.length, (index) => false);

    return StatefulBuilder(
      builder: (context, setState) {
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: branches.asMap().entries.map((entry) {
            int index = entry.key;
            String branch = entry.value.name;
            return ChoiceChip(
              label: Text(branch),
              selected: isSelected[index],
              checkmarkColor: Colors.white,
              selectedColor: const Color(0xFFFD275F),
              backgroundColor: Colors.white,
              side: BorderSide(
                color: const Color(0xFFFD275F),
                width: 1.0,
              ),
              labelStyle: TextStyle(
                color: isSelected[index] ? Colors.white : const Color(0xFFFD275F),
                fontWeight: FontWeight.bold,
              ),
              onSelected: (selected) {
                setState(() {
                  isSelected[index] = selected;
                });
              },
            );
          }).toList(),
        );
      },
    );
  }


  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
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
            borderRadius: BorderRadius.only(topLeft:8.circularRadius,topRight: 8.circularRadius)
          ),
        ),
        child: Text("Filtrele",style: styleWhite14Bold,)
      ),
    );
  }
}
