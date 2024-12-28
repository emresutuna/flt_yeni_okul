import 'package:baykurs/ui/coursedetail/bloc/CourseDetailBloc.dart';
import 'package:baykurs/ui/coursedetail/bloc/CourseDetailEvent.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/HexColor.dart';
import '../../util/LessonExtension.dart';
import '../../util/YOColors.dart';
import '../../widgets/infoWidget/InfoWidget.dart';
import 'bloc/CourseDetailState.dart';
import 'model/CourseDetailResponseModel.dart';

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
          return const Center(child: CircularProgressIndicator());
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
                              // Course Title and Price
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                        courseDetail!.title??"",
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
                                    child: Text("₺${courseDetail!.price}",
                                        textAlign: TextAlign.end,
                                        style: styleBlack22Bold.copyWith(
                                            color: greenButton)),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Tarih: ",
                                            style: styleBlack12Bold,
                                          ),
                                          Text(
                                            courseDetail!.formattedStartDate ?? "",
                                            style: styleBlack12Regular,
                                          ),
                                          const Spacer(),

                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text("Derslik: ",
                                              style: styleBlack12Bold),
                                          Text(courseDetail!.classroom ?? "Bilinmiyor",
                                              style: styleBlack12Regular),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text("Kontenjan: ",
                                              style: styleBlack12Bold),
                                          Text("${courseDetail!.quota}",
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
                                      color:
                                          HexColor( BranchesExtension.getColorForBranch(
                                            courseDetail?.lesson?.name ?? courseDetail?.lessonName ?? "Ders bulunamadı",
                                          ) ?? DEFAULT_LESSON_COLOR),
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
                                'Lorem ipsum dolar sit amet amet lorem ipsum dolar amet lorem ipsum amet dolar sit amet.',
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
                                  courseDetail!.teacherFormatted??""
                                     ,
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
