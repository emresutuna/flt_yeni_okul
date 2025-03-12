import 'package:baykurs/ui/coursedetail/bloc/course_detail_bloc.dart';
import 'package:baykurs/ui/coursedetail/bloc/course_detail_event.dart';
import 'package:baykurs/ui/payment/model/PaymentPreview.dart';
import 'package:baykurs/widgets/BkMapWidget.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../util/GlobalLoading.dart';
import '../../util/HexColor.dart';
import '../../util/LessonExtension.dart';
import '../../util/PriceFormatter.dart';
import '../../util/YOColors.dart';
import 'bloc/course_detail_state.dart';
import 'model/course_detail_response_model.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({super.key});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late int courseId;
  CourseDetailData? courseDetail;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context) != null) {
        courseId = ModalRoute.of(context)!.settings.arguments as int;
        context.read<CourseDetailBloc>().add(FetchCourseById(id: courseId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Ders Detayı"),
      body: BlocBuilder<CourseDetailBloc, CourseDetailState>(
          builder: (context, state) {
        if (state is CourseDetailStateLoading) {
          return const GlobalFadeAnimation();
        } else if (state is CourseDetailStateSuccess) {
          courseDetail = state.courseResponseModel.data;
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(courseDetail!.title ?? "",
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
                                    child: Text(
                                        formatPrice(courseDetail!.price),
                                        textAlign: TextAlign.end,
                                        style: styleBlack20Bold.copyWith(
                                            color: greenButton)),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Tarih: ",
                                            style: styleBlack12Regular,
                                          ),
                                          Text(
                                            courseDetail!.formattedStartDate ??
                                                "",
                                            style: styleBlack12Bold,
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text("Derslik: ",
                                              style: styleBlack12Regular),
                                          Text(
                                              courseDetail!.classroom ??
                                                  "Bilinmiyor",
                                              style: styleBlack12Bold),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text("Kontenjan: ",
                                              style: styleBlack12Regular),
                                          Text("${courseDetail!.quota}",
                                              style: styleBlack12Bold),
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
                                                courseDetail?.lesson?.name ??
                                                    courseDetail?.lessonName ??
                                                    "Ders bulunamadı",
                                              ) ??
                                              DEFAULT_LESSON_COLOR),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      courseDetail!.lesson?.name ??
                                          courseDetail!.lessonName ??
                                          "",
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
                              Text(
                                'Ders Açıklaması',
                                style: styleBlack14Bold,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                courseDetail?.description ?? "",
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

                              Text(courseDetail!.teacherFormatted ?? "",
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

                              Text(
                                  courseDetail!.school?.name ??
                                      courseDetail!.schoolName ??
                                      "",
                                  style: styleBlack12Bold),
                              Text('Fatih Mahallesi No:20 Fatih/İstanbul',
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
                                  latitude: courseDetail!.school!.latitude!,
                                  longitude: courseDetail!.school!.longitude!,
                                  zoom: 15,
                                  schoolName: courseDetail!.school?.name ??
                                      courseDetail!.schoolName ??
                                      "",
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
                        Navigator.pushNamed(context, '/paymentPreview',
                            arguments: PaymentPreview.fromObject(courseDetail));
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
      }),
    );
  }
}
