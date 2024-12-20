import 'package:baykurs/ui/coursedetail/bloc/CourseDetailBloc.dart';
import 'package:baykurs/ui/coursedetail/bloc/CourseDetailEvent.dart';
import 'package:baykurs/ui/coursedetail/bloc/CourseDetailState.dart';
import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/BaseCourseModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/HexColor.dart';
import '../../util/YOColors.dart';
import '../../widgets/InfoWidget.dart';
import '../../widgets/WhiteAppBar.dart';

class TeacherCoachDetail extends StatefulWidget {
  const TeacherCoachDetail({super.key});

  @override
  State<TeacherCoachDetail> createState() => _TeacherCoachDetailState();
}

class _TeacherCoachDetailState extends State<TeacherCoachDetail> {
  late List<BaseCourse> courseDetail;
  late int courseId;
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
            .add(FetchCourseCoachById(id: courseId));
      }
    });
  }

  void extractDates() {
    dates = courseDetail
        .map((course) => course.startDate?.split("T")[0] ?? "")
        .toSet()
        .toList();
    if (selectedDate.isEmpty && dates.isNotEmpty) {
      selectedDate = dates.first; // Varsayılan olarak ilk tarihi seç
    }
  }

  // Seçili tarihe ait dersleri getir
  List<BaseCourse> getLessonsForSelectedDate() {
    return courseDetail
        .where((course) => (course.startDate ?? "").startsWith(selectedDate))
        .toList();
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
      appBar: WhiteAppBar("Eğitim Koçu Detay"),
      body: BlocBuilder<CourseDetailBloc, CourseDetailState>(
          builder: (context, state) {
        if (state is CourseDetailStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CourseCoachDetailSuccess) {
          courseDetail = state.courseCoachResponse.data!;
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
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 24, bottom: 16),
                          child: Text(
                            "Lorem ipsum dolar sit amet",
                            style: styleBlack12Bold,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const InfoCardWidget(
                          title: 'Bilgi',
                          description:
                              'Bir bölgedeki tüm kurumlardan ya da tek bir kurumdan ders talebinde bulunarak, kurumların bir sonraki haftanın ders programına talep ettiğin dersi eklemelerini sağlayabilirsin.',
                          icon: Icons.info_outline,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: HexColor("F9F9F9"),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Course Title and Price
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(courseDetail.first.title ?? "",
                                        style: styleBlack14Bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    "",
                                    style: styleBlack12Regular,
                                  ),
                                  const Spacer(),
                                  Text("${courseDetail.first.price} ₺",
                                      style: styleBlack16Bold.copyWith(
                                          color: greenButton)),
                                ],
                              ),
                              const SizedBox(height: 4),

                              Row(
                                children: [
                                  const Icon(Icons.room,
                                      size: 16, color: Colors.grey),
                                  Text(courseDetail.first.classroom ?? "",
                                      style: styleBlack12Regular),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Lesson Badge and Description
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: HexColor('#4A90E2'),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      courseDetail.first.lesson?.name ??
                                          courseDetail.first.lessonName ??
                                          "Ders bulunamadı",
                                      style: styleWhite12Bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Divider(
                                height: 1,
                                color: Colors.black38.withAlpha(40),
                              ),
                              const SizedBox(height: 8),

                              Text("Tarih Seçin:", style: styleBlack14Bold),
                              SizedBox(
                                height: 60,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: dates.length,
                                  itemBuilder: (context, index) {
                                    final isSelected =
                                        selectedDate == dates[index];
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedDate = dates[index];
                                          selectedTime = null;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        margin: const EdgeInsets.all(8.0),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? color5
                                              : Colors.grey.shade300,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Center(
                                          child: Text(dates[index],
                                              style: styleBlack12Bold.copyWith(
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors.black,
                                              )),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              8.toHeight,
                              Divider(
                                height: 1,
                                color: Colors.black38.withAlpha(40),
                              ),
                              8.toHeight,
                              // Saat Seçici
                              Text("Saat Seçin:", style: styleBlack14Bold),
                              Wrap(
                                spacing: 10,
                                children: getTimesForSelectedDate().map((time) {
                                  final isSelected = selectedTime == time;
                                  return ChoiceChip(
                                    label: Text(time,
                                        style: styleBlack12Bold.copyWith(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        )),
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
                              8.toHeight,
                              Divider(
                                height: 1,
                                color: Colors.black38.withAlpha(40),
                              ),
                              8.toHeight,
                              Text(
                                'Ders Açıklaması',
                                style: styleBlack14Bold,
                              ),
                              const SizedBox(height: 8),

                              Text(
                                courseDetail.first.title ?? "",
                                style: styleBlack12Regular,
                              ),
                              const SizedBox(height: 12),
                              const SizedBox(height: 8),
                              Divider(
                                height: 1,
                                color: Colors.black38.withAlpha(40),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Öğretmen Bilgisi',
                                style: styleBlack14Bold,
                              ),
                              const SizedBox(height: 8),

                              Text(courseDetail.first.teacherFormatted ?? "",
                                  style: styleBlack12Regular),
                              const SizedBox(height: 8),
                              Divider(
                                height: 1,
                                color: Colors.black38.withAlpha(40),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Kurum Bilgisi',
                                style: styleBlack14Bold,
                              ),
                              const SizedBox(height: 8),

                              Text(courseDetail.first.school?.name ?? "",
                                  style: styleBlack12Bold),
                              Text(courseDetail.first.school?.address ?? "",
                                  style: styleBlack12Regular),
                              const SizedBox(height: 16),
                              // Placeholder for the map image
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                    child: Icon(Icons.map,
                                        size: 50, color: Colors.grey)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        )
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
                        backgroundColor: color3,
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
                      child: Text(
                        "Satın Al",
                        style: styleWhite16Bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is CourseDetailStateError) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return SizedBox();
        }
      }),
    );
  }
}
