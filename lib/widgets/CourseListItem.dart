import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../ui/course/model/CourseModel.dart';
import '../util/HexColor.dart';
import '../util/LessonExtension.dart';
import '../util/YOColors.dart';
import 'TertiaryButton.dart';

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

    String dateString =
        courseModel?.startDate != null ? courseModel!.startDate! : '-';

    String timeString = courseModel?.startDate != null
        ? DateFormat('HH:mm').format(DateTime.parse(courseModel!.startDate!))
        : '-';

    String endTime = courseModel?.endDate != null
        ? DateFormat('HH:mm').format(DateTime.parse(courseModel!.endDate!))
        : '-';

    String price = '${courseModel?.price ?? 0} ₺';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 4.0,
        decoration: BoxDecoration(
          color: HexColor("#F7F9F9"),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 0.5,
            color: HexColor("#222831").withAlpha(60),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 11,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    teacherName.isEmpty
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Eğitmen: $teacherName",
                              style: styleBlack12Regular,
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Tarih: ${courseModel?.formattedStartDate ?? ""} - $endTime",
                        style: styleBlack12Regular,
                      ),
                    ),
                    courseModel?.topics != null &&
                            courseModel!.topics!.isNotEmpty
                        ? Padding(
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
                          )
                        : const SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Text(
                            price,
                            style: styleGreen18Bold,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 8,
                          ),
                          TertiaryButton(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: 40,
                            borderRadius: 8,
                            text: "Satın Al",
                            textColor: null,
                            onPress: () {
                              // Satın alma işlemi için yapılacaklar
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: double.maxFinite,
                decoration: ShapeDecoration(
                  color: HexColor(BranchesExtension.getColorForBranch(
                        courseModel?.lesson?.name ??
                            courseModel?.lessonName ??
                            DEFAULT_LESSON_COLOR,
                      ) ??
                      DEFAULT_LESSON_COLOR),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                ),
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      lessonName,
                      textAlign: TextAlign.center,
                      style: styleWhite12Bold,
                    ),
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
