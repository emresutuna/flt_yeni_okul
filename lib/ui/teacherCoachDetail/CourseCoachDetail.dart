import 'package:baykurs/ui/courseBundleDetail/model/CourseBundleDetailResponse.dart';
import 'package:baykurs/ui/coursedetail/bloc/CourseDetailBloc.dart';
import 'package:baykurs/ui/coursedetail/bloc/CourseDetailEvent.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../util/BaseCourseModel.dart';
import '../../util/HexColor.dart';
import '../../util/YOColors.dart';
import '../../widgets/infoWidget/InfoWidget.dart';
import '../coursedetail/bloc/CourseDetailState.dart';

class CourseBundleDetailPage extends StatefulWidget {
  const CourseBundleDetailPage({super.key});

  @override
  State<CourseBundleDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseBundleDetailPage> {
  late int courseId;
  CourseBundleData? courseDetail;
  List<String> dates = [];
  String selectedDate = "";
  String? selectedTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context) != null) {
        courseId = ModalRoute.of(context)!.settings.arguments as int;
        context
            .read<CourseDetailBloc>()
            .add(FetchCourseBundleById(id: courseId));
      }
    });
  }

  // Tarihleri ayır
  void extractDates() {
    if (courseDetail != null) {
      dates = courseDetail!.courses
          .map((course) => course.startDate?.split("T")[0] ?? "")
          .toSet()
          .toList();
      if (selectedDate.isEmpty && dates.isNotEmpty) {
        selectedDate = dates.first; // Varsayılan olarak ilk tarihi seç
      }
    }
  }

  // Seçili tarihe ait dersleri getir
  List<BaseCourse> getLessonsForSelectedDate() {
    return courseDetail?.courses
        .where(
            (course) => (course.startDate ?? "").startsWith(selectedDate))
        .toList() ??
        [];
  }

  // Seçili tarihe ait saatleri getir
  List<String> getTimesForSelectedDate() {
    return getLessonsForSelectedDate().map((course) {
      final startTime = course.startDate?.split('T')[1].substring(0, 5) ?? "";
      final endTime = course.endDate?.split('T')[1].substring(0, 5) ?? "";
      return "$startTime - $endTime";
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Ders Detayı"),
      body: BlocBuilder<CourseDetailBloc, CourseDetailState>(
        builder: (context, state) {
          if (state is CourseDetailStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CourseBundleDetailStateSuccess) {
            courseDetail = state.courseResponseModel.data;
            extractDates();

            return SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const InfoCardWidget(
                            title: 'Bilgi',
                            description:
                            'Bir bölgedeki tüm kurumlardan ya da tek bir kurumdan ders talebinde bulunarak, kurumların bir sonraki haftanın ders programına talep ettiğin dersi eklemelerini sağlayabilirsin.',
                            icon: Icons.info_outline,
                          ),
                          const SizedBox(height: 16),

                          // Tarih Seçici
                          Text("Tarih Seçin:", style: styleBlack16Bold),
                          SizedBox(
                            height: 60,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dates.length,
                              itemBuilder: (context, index) {
                                final isSelected = selectedDate == dates[index];

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedDate = dates[index];
                                      selectedTime = null;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.all(8.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? color5
                                          : Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Center(
                                      child: Text(dates[index],
                                          style: styleBlack12Bold.copyWith(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                          )
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 16),
                          const Text("Saat Seçin:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),

                          Wrap(
                            spacing: 10,
                            children: getTimesForSelectedDate().map((time) {
                              final isSelected = selectedTime == time;
                              return ChoiceChip(
                                label: Text(
                                  time,
                                  style: styleBlack12Bold.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                selected: isSelected,
                                selectedColor: Colors.green,
                                onSelected: (bool selected) {
                                  setState(() {
                                    selectedTime = time;
                                  });
                                },
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 60,
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor("#4A90E2"),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/paymentPreview',
                              arguments: courseDetail);
                        },
                        child: const Text(
                          "Satın Al",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CourseDetailStateError) {
            return Center(child: Text('Hata: ${state.error}'));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
