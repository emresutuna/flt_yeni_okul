import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../ui/course/model/CourseModel.dart';
import '../ui/coursedetail/model/CourseDetailResponseModel.dart';
import '../ui/dashboard/model/MobileHomeResponse.dart';
import '../util/DateExtension.dart';
import '../util/HexColor.dart';
import '../util/LessonExtension.dart';
import '../util/PriceFormatter.dart';
import '../util/YOColors.dart';

class CourseListItem extends StatelessWidget {
  final CourseList? courseModel;
  final Color colors;

  const CourseListItem(
      {super.key, required this.courseModel, required this.colors});

  @override
  Widget build(BuildContext context) {
    String lessonName = courseModel?.lesson?.name ??
        courseModel?.lessonName ??
        'Ders bilgisi bulunamadı';
    String title = courseModel?.title ?? 'Ders bilgisi bulunamadı';
    String schoolName = courseModel?.schoolName ?? 'Kurum bilgisi yok';
    String teacherName = courseModel?.teacherFormatted ?? '';

    String endTime = courseModel?.endDate != null
        ? DateFormat('HH:mm').format(DateTime.parse(courseModel!.endDate!))
        : '-';
    String price = formatPrice(courseModel?.price ?? 0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 11,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: HexColor("#F7F9F9"),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  border: Border.all(
                    width: 0.5,
                    color: HexColor("#222831").withAlpha(60),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: styleBlack14Bold,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Kurum: ",
                              style: styleBlack12Regular,
                            ),
                            TextSpan(
                              text: schoolName,
                              style: styleBlack12Bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (teacherName.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Öğretmen: ",
                                style: styleBlack12Regular,
                              ),
                              TextSpan(
                                text: teacherName,
                                style: styleBlack12Bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Tarih: ",
                              style: styleBlack12Regular, // "Tarih:" kısmı bold olacak
                            ),
                            TextSpan(
                              text: "${courseModel?.formattedStartDate ?? ""} - $endTime",
                              style: styleBlack12Bold, // Tarih verileri normal olacak
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (courseModel?.topics != null &&
                        courseModel!.topics!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Konular: ",
                                style: styleBlack12Regular,
                              ),
                              TextSpan(
                                text: courseModel?.topics
                                        ?.map((e) => e.name)
                                        .join(" - ") ??
                                    "",
                                style: styleBlack12Bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Text(
                            price,
                            style: styleGreen18Bold,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 32, // Sabit genişlikte kenar sütunu
              decoration: BoxDecoration(
                color: HexColor(
                  BranchesExtension.getColorForBranch(
                        courseModel?.lesson?.name ??
                            courseModel?.lessonName ??
                            DEFAULT_LESSON_COLOR,
                      ) ??
                      DEFAULT_LESSON_COLOR,
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: RotatedBox(
                quarterTurns: 3,
                child: Center(
                  child: Text(
                    lessonName,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: styleWhite12Bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

CourseDetailData mapCourseListToDetail(CourseList courseList) {
  return CourseDetailData(
    id: courseList.id,
    title: courseList.title,
    description: courseList.description,
    startDate: courseList.startDate,
    endDate: courseList.endDate,
    price: courseList.price,
    quota: courseList.quota,
    schoolName: courseList.schoolName,
    school: courseList.school,
    topics: courseList.topics,
    classroom: null,
    teacherName: null,
    teacherSurname: null,
  );
}

class InterestedLessonWidget extends StatelessWidget {
  final InterestedLesson? courseModel;
  final Color colors;

  const InterestedLessonWidget(
      {super.key, required this.courseModel, required this.colors});

  @override
  Widget build(BuildContext context) {
    String lessonName = courseModel?.lesson?.name ?? 'Ders bilgisi bulunamadı';
    String title = courseModel?.title ?? 'Ders bilgisi bulunamadı';
    String schoolName = courseModel?.school?.user?.name ?? 'Kurum bilgisi yok';

    String dateString = formatDateRange(
        DateTime.parse(courseModel?.startDate ?? ""),
        DateTime.parse(courseModel?.endDate ?? ""));

    String timeString = courseModel?.startDate != null
        ? DateFormat('HH:mm').format(DateTime.parse(courseModel!.startDate!))
        : '-';

    String endTime = courseModel?.endDate != null
        ? DateFormat('HH:mm').format(DateTime.parse(courseModel!.endDate!))
        : '-';

    String price = formatPrice(courseModel?.price ??"");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 11,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: HexColor("#F7F9F9"),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  border: Border.all(
                    width: 0.5,
                    color: HexColor("#222831").withAlpha(60),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: styleBlack14Bold,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Kurum: $schoolName",
                        style: styleBlack12Bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Tarih: $dateString",
                        style: styleBlack12Regular,
                      ),
                    ),
                    if (courseModel?.topics != null &&
                        courseModel!.topics!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Konular: ",
                                style: styleBlack12Regular.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: courseModel?.topics
                                        ?.map((e) => e.name)
                                        .join(" - ") ??
                                    "",
                                style: styleBlack12Regular,
                              ),
                            ],
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Text(
                            price,
                            style: styleGreen18Bold,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 32, // Sabit genişlikte kenar sütunu
              decoration: BoxDecoration(
                color: HexColor(
                  BranchesExtension.getColorForBranch(
                        courseModel?.lesson?.name ?? DEFAULT_LESSON_COLOR,
                      ) ??
                      DEFAULT_LESSON_COLOR,
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: RotatedBox(
                quarterTurns: 3,
                child: Center(
                  child: Text(
                    lessonName,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: styleWhite12Bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
