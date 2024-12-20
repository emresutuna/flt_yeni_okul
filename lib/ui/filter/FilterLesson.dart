import 'package:baykurs/ui/course/model/CourseFilter.dart';
import 'package:baykurs/ui/course/model/CourseTypeEnum.dart';
import 'package:baykurs/ui/filter/FilterProvince.dart';
import 'package:baykurs/ui/filter/FilterRegion.dart';
import 'package:baykurs/ui/filter/bloc/FilterBloc.dart';
import 'package:baykurs/ui/filter/bloc/FilterEvent.dart';
import 'package:baykurs/ui/filter/bloc/FilterState.dart';
import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../util/LessonExtension.dart';
import '../requestlesson/Region.dart';
import 'FilterTopic.dart';

class FilterLesson extends StatefulWidget {
  final CourseFilter courseFilter;
  final CourseTypeEnum courseTypeEnum;

  const FilterLesson(
      {super.key, required this.courseFilter, required this.courseTypeEnum});

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
  late CourseTypeEnum courseType;
  bool isLoading = false;

  List<bool> isSelected = [];
  bool hasSelectableTopic = false;
  late RangeValues _currentRange;
  double maxPriceData = 0.0;

  @override
  void initState() {
    super.initState();
    courseFilter = widget.courseFilter;
    courseType = widget.courseTypeEnum;
    _currentRange = const RangeValues(0, 100.0);
    initializeFields();
    context.read<FilterBloc>().add(FetchMaxPrice(courseTypeEnum: courseType));
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
      body: BlocBuilder<FilterBloc, FilterState>(builder: (context, state) {
        if (state is FilterStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FilterStateSuccess) {
          final maxPriceData =
              double.tryParse(state.priceModel.data?.maxPrice ?? "0.0") ?? 0.0;
          if (_currentRange.start == 0.0 && _currentRange.end == 100.0) {
            _currentRange = RangeValues(0.0, maxPriceData);
          }
          return Stack(
            children: [
              Column(
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
                            priceRangeSlider(
                              ctx: context,
                              minValue: 0.0,
                              maxValue: maxPriceData,
                              currentRange: _currentRange,
                              onChanged: (newRange) {
                                setState(() {
                                  _currentRange = newRange; // Değeri güncelle
                                });
                              },
                              leftLabel:
                                  "Min: ${_currentRange.start.toInt()} TL",
                              rightLabel:
                                  "Max: ${_currentRange.end.toInt()} TL",
                              activeColor: Colors.orange,
                              inactiveColor: Colors.grey[300]!,
                            ),
                            16.toHeight,
                            Text("İl", style: styleBlack16Bold),
                            16.toHeight,
                            _buildTextField(
                                "İl Seç", ilController, context, true),
                            16.toHeight,
                            Text("İlçe", style: styleBlack16Bold),
                            16.toHeight,
                            _buildTextField(
                                "İlçe Seç", ilceController, context, false),
                            16.toHeight,
                            if (courseType == CourseTypeEnum.COURSE ||
                                courseType == CourseTypeEnum.COURSE_BUNDLE) ...[
                              Text("Branş", style: styleBlack18Bold),
                              16.toHeight,
                              _buildBranches(),
                              16.toHeight,
                            ],
                            if (courseType == CourseTypeEnum.COURSE) ...[
                              Text("Konu", style: styleBlack18Bold),
                              16.toHeight,
                              _buildTopicSelector(),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
                  _buildFilterButton(),
                ],
              ),
            ],
          );
        } else {
          return SizedBox();
        }
      }),
    );
  }

  void updateRange(RangeValues newRange) {
    setState(() {
      _currentRange = newRange; // State'i güncelle
      courseFilter = courseFilter.copyWith(
        minPrice: newRange.start.toInt(),
        maxPrice: newRange.end.toInt(),
      );
    });
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
            builder: (context) => FilterTopicPage(
              initialTopicId: courseFilter.topicId,
              topics: filterBranchTopicsByBranchId(
                classLevelBranches,
                (courseFilter.lessonId != null
                    ? courseFilter.lessonId! - 1
                    : -1),
              ),
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
      children: branches.asMap().entries.map((entry) {
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
                  lessonId: index + 1,
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

Widget priceRangeSlider2({
  required BuildContext ctx,
  required double minValue,
  required double maxValue,
  required RangeValues currentRange,
  required ValueChanged<RangeValues> onChanged,
}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Min: ${currentRange.start.toInt()} TL",
              style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          Text("Max: ${currentRange.end.toInt()} TL",
              style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        ],
      ),
      SliderTheme(
        data: SliderTheme.of(ctx).copyWith(
          trackHeight: 2,
          activeTrackColor: Colors.blueAccent,
          inactiveTrackColor: Colors.grey[300],
          thumbColor: Colors.blueAccent,
          overlayColor: Colors.blueAccent.withOpacity(0.3),
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
          rangeThumbShape:
              const RoundRangeSliderThumbShape(enabledThumbRadius: 10),
        ),
        child: RangeSlider(
          values: currentRange,
          min: minValue,
          max: maxValue,
          onChanged: onChanged, // Güncellemeyi burada sağlıyoruz
        ),
      ),
    ],
  );
}

Widget priceRangeSlider({
  required double minValue,
  required double maxValue,
  required RangeValues currentRange,
  required ValueChanged<RangeValues> onChanged,
  String? leftLabel,
  String? rightLabel,
  Color activeColor = Colors.orange,
  Color inactiveColor = Colors.grey,
  required BuildContext ctx,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(leftLabel ?? "${currentRange.start.toInt()} TL",
                style: TextStyle(color: Colors.grey[600], fontSize: 14)),
            Text(rightLabel ?? "${currentRange.end.toInt()} TL",
                style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(ctx).copyWith(
            trackHeight: 2,
            activeTrackColor: activeColor.withOpacity(0.9),
            inactiveTrackColor: inactiveColor,
            thumbColor: activeColor,
            overlayColor: activeColor.withOpacity(0.7),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
            rangeThumbShape:
                const RoundRangeSliderThumbShape(enabledThumbRadius: 10.0),
          ),
          child: RangeSlider(
            values: currentRange,
            min: minValue,
            max: maxValue,
            onChanged: (RangeValues newRange) {
              onChanged(newRange);
            },
          ),
        ),
      ],
    ),
  );
}
