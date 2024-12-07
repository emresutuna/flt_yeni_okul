import 'package:baykurs/ui/course/model/CourseFilter.dart';
import 'package:baykurs/ui/filter/FilterProvince.dart';
import 'package:baykurs/ui/filter/FilterRegion.dart';
import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';

import '../../util/LessonExtension.dart';
import '../priceFilter/PriceFilterPage.dart';
import '../requestlesson/Region.dart';
import 'FilterTopic.dart';

class FilterLesson extends StatefulWidget {
  final CourseFilter courseFilter;

  const FilterLesson({super.key, required this.courseFilter});

  @override
  _FilterLessonState createState() => _FilterLessonState();
}

class _FilterLessonState extends State<FilterLesson> {
  final TextEditingController konuController = TextEditingController();
  final TextEditingController ilController = TextEditingController();
  final TextEditingController ilceController = TextEditingController();

  Region? selectedCity;
  Province? selectedProvince;
  late CourseFilter courseFilter;

  List<bool> isSelected = [];
  bool hasSelectableTopic = false;

  @override
  void initState() {
    super.initState();
    courseFilter = widget.courseFilter;
    initializeFields();
  }

  void initializeFields() {
    konuController.text = courseFilter.query ?? '';
    ilController.text = courseFilter.provinceName ?? '';
    ilceController.text = courseFilter.cityName ?? '';

    selectedCity = courseFilter.cityId != null
        ? Region(id: courseFilter.cityId!, name: courseFilter.cityName ?? "")
        : null;

    selectedProvince = courseFilter.provinceId != null
        ? Province(
        id: courseFilter.provinceId!, name: courseFilter.provinceName ?? "")
        : null;

    // Branşların seçim durumunu ayarla
    isSelected = List.generate(
      BranchesExtension.allBranches.length,
          (index) => courseFilter.lessonId == index + 1,
    );
  }

  void clearFilters() {
    setState(() {
      konuController.clear();
      ilController.clear();
      ilceController.clear();
      courseFilter = CourseFilter();
      selectedCity = null;
      selectedProvince = null;
      isSelected = List.generate(isSelected.length, (_) => false);
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
        title: Text("Filtrele", style: styleBlack16Bold),
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
                      const Text(
                          "Herhangi birini seçerek kullanıcı bilgilerini güncelleyebilirsiniz"),
                      16.toHeight,
                      Text("Fiyat", style: styleBlack18Bold),
                      16.toHeight,
                      PriceFilter(
                        minLimit: 0,
                        maxLimit: 50000,
                        onApply: (minValue, maxValue) {
                          setState(() {
                            courseFilter = courseFilter.copyWith(
                              minPrice: minValue.toInt(),
                              maxPrice: maxValue.toInt(),
                            );
                          });
                        },
                      ),
                      16.toHeight,
                      Text("İl", style: styleBlack16Bold),
                      16.toHeight,
                      _buildTextField("İl Seç", ilController, context, true),
                      16.toHeight,
                      Text("İlçe", style: styleBlack16Bold),
                      16.toHeight,
                      _buildTextField(
                          "İlçe Seç", ilceController, context, false),
                      16.toHeight,
                      Text("Branş", style: styleBlack18Bold),
                      16.toHeight,
                      _buildBranches(),
                      16.toHeight,
                      Text("Konu", style: styleBlack18Bold),
                      16.toHeight,
                      _buildTopicSelector(),
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

  Widget _buildTopicSelector() {
    return GestureDetector(
      onTap: () async {
        if (!hasSelectableTopic) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Lütfen önce bir branş seçin.")),
          );
          return;
        }

        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FilterTopicPage(
                  initialTopicId: courseFilter.topicId,
                  topics: filterBranchTopicsByBranchId(
                      classLevelBranches, courseFilter.lessonId ?? -1),
                ),
          ),
        );
        if (result != null && result is Map<String, dynamic>) {
          setState(() {
            courseFilter = courseFilter.copyWith(topicId: result['id']);
            konuController.text = result['name'];
          });
        }
      },
      child: AbsorbPointer(
        child: TextField(
          controller: TextEditingController(
            text:
            courseFilter.topicId != null ? konuController.text : "Konu Seç",
          ),
          decoration: InputDecoration(
            hintText: "Konu Seç",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller,
      BuildContext context, bool isCity) {
    return GestureDetector(
      onTap: () async {
        if (isCity) {
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
        } else {
          if (selectedCity != null) {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FilterProvince(
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
        }
      },
      child: AbsorbPointer(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    );
  }

  Widget _buildBranches() {
    final branches = BranchesExtension.allBranches;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: branches
          .asMap()
          .entries
          .map((entry) {
        int index = entry.key;
        String branch = entry.value.value;
        return ChoiceChip(
          label: Text(branch),
          selected: isSelected[index],
          checkmarkColor: Colors.white,
          selectedColor: color5,
          backgroundColor: Colors.white,
          side: BorderSide(color: color5, width: 1.0),
          labelStyle: TextStyle(
            color: isSelected[index] ? Colors.white : color5,
            fontWeight: FontWeight.bold,
          ),
          onSelected: (selected) {
            setState(() {
              if (isSelected[index]) {
                if (courseFilter.topicId == null) {
                  isSelected[index] = false;
                  courseFilter = courseFilter.copyWith(lessonId: null);
                  hasSelectableTopic = false;
                }
              } else {

                isSelected = List.generate(isSelected.length, (_) => false);
                isSelected[index] = true;
                courseFilter = courseFilter.copyWith(
                  lessonId: index,
                  topicId: null,
                );
                konuController.clear();
                hasSelectableTopic = true;
              }
            });
          },
        );
      }).toList(),
    );
  }


  Widget _buildFilterButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          final updatedFilter = courseFilter.copyWith(
            query: konuController.text.isNotEmpty ? konuController.text : null,
            provinceName:
            ilController.text.isNotEmpty ? ilController.text : null,
            cityName:
            ilceController.text.isNotEmpty ? ilceController.text : null,
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
              topLeft: 8.circularRadius,
              topRight: 8.circularRadius,
            ),
          ),
        ),
        child: Text("Filtrele", style: styleWhite14Bold),
      ),
    );
  }
}
