import 'package:baykurs/ui/courseBundleDetail/model/CourseBundleDetailResponse.dart';
import 'package:baykurs/ui/coursedetail/bloc/CourseDetailBloc.dart';
import 'package:baykurs/ui/coursedetail/bloc/CourseDetailEvent.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../util/HexColor.dart';
import '../../util/LessonExtension.dart';
import '../../util/YOColors.dart';
import '../../widgets/InfoWidget.dart';
import '../coursedetail/bloc/CourseDetailState.dart';

class CourseBundleDetailPage extends StatefulWidget {
  const CourseBundleDetailPage({super.key});

  @override
  State<CourseBundleDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseBundleDetailPage> {
  late int courseId;
  CourseBundleData? courseDetail;

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
                                    child: Text(courseDetail!.title ?? "",
                                        style: styleBlack14Bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    courseDetail!
                                            .courses.first.formattedStartDate ??
                                        "",
                                    style: styleBlack12Regular,
                                  ),
                                  const Spacer(),
                                  Text("${courseDetail!.price} ₺",
                                      style: styleBlack16Bold.copyWith(
                                          color: greenButton)),
                                ],
                              ),
                              const SizedBox(height: 4),

                              Row(
                                children: [
                                  const Icon(Icons.room,
                                      size: 16, color: Colors.grey),
                                  Text("Bilinmiyor",
                                      style: styleBlack12Regular),
                                ],
                              ),
                              const SizedBox(height: 4),
                              /*
                                  Text("Kontenjan: ${courseDetail!.quota}",
                                      style: styleBlack12Regular),

                                   */

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
                                                courseDetail?.courses.first
                                                        .lesson?.name ??
                                                    courseDetail?.courses.first
                                                        .lessonName ??
                                                    "Ders bulunamadı",
                                              ) ??
                                              "#4A90E2"),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      courseDetail!
                                              .courses.first.lesson?.name ??
                                          courseDetail!
                                              .courses.first.lessonName ??
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
                                  courseDetail!.courses.first.school?.name ??
                                      courseDetail!.courses.first.schoolName ??
                                      "",
                                  style: styleBlack12Bold),
                              Text(courseDetail?.courses.first.school?.address ??"",
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
