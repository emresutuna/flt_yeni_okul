import 'package:baykurs/ui/dashboard/model/MobileHomeResponse.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../util/HexColor.dart';
import '../../util/LessonExtension.dart';
import '../../util/YOColors.dart';

class IncomingCourse extends StatelessWidget {
  final IncomingLesson? courseModel;
  final Color colors;


  const IncomingCourse(
      {super.key, required this.courseModel, required this.colors});

  @override
  Widget build(BuildContext context) {
    String lessonName = courseModel?.lesson?.name ??
        courseModel?.lesson?.name ??
        'Ders bilgisi bulunamadı';
    String title = courseModel?.title ?? 'Ders bilgisi bulunamadı';
    String schoolName = courseModel?.school?.user?.name ?? 'Kurum bilgisi yok';
    String teacherName = 'Öğretmen Bilgisi Bulunamadı';

    String dateString =
    courseModel?.startDate != null ? courseModel!.startDate! : '-';

    String timeString = courseModel?.startDate != null
        ? DateFormat('HH:mm').format(DateTime.parse(courseModel!.startDate!))
        : '-';

    String endTime = courseModel?.endDate != null
        ? DateFormat('HH:mm').format(DateTime.parse(courseModel!.endDate!))
        : '-';

    String price = '₺${courseModel?.price ?? 0}';

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
                    if (teacherName.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Eğitmen: $teacherName",
                          style: styleBlack12Regular,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Tarih: ${timeString ?? ""} - $endTime",
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
              width: 32,
              decoration: BoxDecoration(
                color: HexColor(
                  BranchesExtension.getColorForBranch(
                    courseModel?.lesson?.name??
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