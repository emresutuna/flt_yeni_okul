import 'package:baykurs/ui/course/model/CourseTypeEnum.dart';
import 'package:baykurs/ui/coursedetail/bloc/CourseDetailBloc.dart';
import 'package:baykurs/ui/coursedetail/bloc/CourseDetailEvent.dart';
import 'package:baykurs/ui/coursedetail/bloc/CourseDetailState.dart';
import 'package:baykurs/ui/payment/model/PaymentPreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../util/HexColor.dart';
import '../../util/LessonExtension.dart';
import '../../util/YOColors.dart';
import '../../widgets/BkMapWidget.dart';
import '../../widgets/WhiteAppBar.dart';
import 'DateTimeSelectorWidget.dart';
import 'model/CourseCoachDetailResponse.dart';

class TeacherCoachDetail extends StatefulWidget {
  const TeacherCoachDetail({super.key});

  @override
  State<TeacherCoachDetail> createState() => _TeacherCoachDetailState();
}

class _TeacherCoachDetailState extends State<TeacherCoachDetail> {
  late CourseData courseDetail;
  List<String> dates = [];
  String selectedDate = "";
  String? selectedTime;
  String selectedClassroom = "-";
  String selectedPrice = "-";
  int selectedCourse = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context) != null) {
        final courseId = ModalRoute.of(context)!.settings.arguments as int;
        context
            .read<CourseDetailBloc>()
            .add(FetchCourseCoachById(id: courseId));
      }
    });
  }

  void extractDates() {
    dates = courseDetail.availableDates.keys.toList();
    if (selectedDate.isEmpty && dates.isNotEmpty) {
      selectedDate = dates.first;
    }
  }

  List<AvailableHour> getLessonsForSelectedDate() {
    return courseDetail.availableDates[selectedDate] ?? [];
  }

  void updateClassroom(String? selectedTime) {
    final selectedLesson = getLessonsForSelectedDate().firstWhere(
        (lesson) => lesson.hour == selectedTime,
        orElse: () =>
            AvailableHour(id: 0, hour: "", classroom: "Bilinmiyor", price: 0));
    setState(() {
      selectedClassroom = selectedLesson.classroom;
      selectedPrice = selectedLesson.price.toString();
      selectedCourse = selectedLesson.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Eğitim Koçu Detay"),
      body: BlocBuilder<CourseDetailBloc, CourseDetailState>(
        builder: (context, state) {
          if (state is CourseDetailStateLoading) {
            return  Center(child: CircularProgressIndicator(color: color5,));
          } else if (state is CourseCoachDetailSuccess) {
            courseDetail = state.courseCoachResponse.data;
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
                                left: 16.0, top: 0, bottom: 16),
                            child: Text(
                              "Derse ait tüm detayları incele.",
                              style: styleBlack12Bold,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: HexColor("#F9F9F9"),
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
                                      child: Text(courseDetail.title,
                                          style: styleBlack14Bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                Stack(
                                  children: [
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Text("₺$selectedPrice",
                                          textAlign: TextAlign.end,
                                          style: styleBlack22Bold.copyWith(
                                              color: greenButton)),
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text("Derslik: ",
                                                style: styleBlack12Bold),
                                            Text(selectedClassroom,
                                                style: styleBlack12Regular),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text("Kontenjan: ",
                                                style: styleBlack12Bold),
                                            Text(courseDetail.quota.toString(),
                                                style: styleBlack12Regular),
                                          ],
                                        ),
                                      ],
                                    )
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
                                        color: HexColor(
                                            BranchesExtension.getColorForBranch(
                                                    courseDetail.lesson) ??
                                                DEFAULT_LESSON_COLOR),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        courseDetail.lesson,
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
                                DateTimeSelectorWidget(
                                  dates: dates,
                                  selectedDate: selectedDate,
                                  onDateSelected: (date) {
                                    setState(() {
                                      selectedDate = date;
                                      selectedTime = null;
                                    });
                                  },
                                  times: getLessonsForSelectedDate()
                                      .map((lesson) => lesson.hour)
                                      .toList(),
                                  selectedTime: selectedTime,
                                  onTimeSelected: (time) {
                                    setState(() {
                                      selectedTime = time;
                                      updateClassroom(time);
                                    });
                                  },
                                ),
                                const SizedBox(height: 8),

                                Divider(
                                  height: 1,
                                  color: Colors.black38.withAlpha(40),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Ders Açıklaması',
                                  style: styleBlack14Bold,
                                ),
                                const SizedBox(height: 8),

                                Text(
                                  courseDetail.description,
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

                                Text(
                                    "${courseDetail.teacherName} ${courseDetail.teacherSurname}",
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

                                Text(courseDetail.school.name,
                                    style: styleBlack12Bold),
                                Text(courseDetail.school.address,
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
                                  child: BkMapWidget(
                                    latitude: courseDetail.school.latitude,
                                    longitude: courseDetail.school.longitude,
                                    zoom: 15,
                                    schoolName: courseDetail.school.name,
                                    onMapCreated:
                                        (GoogleMapController controller) {},
                                  ),
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
                          if (selectedCourse != -1) {
                            Navigator.pushNamed(context, '/paymentPreview',
                                arguments: PaymentPreview(
                                    title: courseDetail.title,
                                    id: selectedCourse,
                                    courseType: CourseTypeEnum.COURSE_COACH,
                                    desc: courseDetail.description,
                                    price: selectedPrice,
                                    teacherName:
                                        "${courseDetail.teacherName} ${courseDetail.teacherSurname}",
                                    schoolName: courseDetail.school.name,
                                    classroom: selectedClassroom,
                                    startDate: "",
                                    endDate: "",
                                    lessonName: courseDetail.lesson));
                          }else{
                            Get.snackbar(
                              "Hata", "Lütfen önce tarih ve saat seçin",
                              colorText: Colors.white,
                              backgroundColor: Colors.red,
                            );
                          }
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
            return const SizedBox();
          }
        },
      ),
    );
  }
}
