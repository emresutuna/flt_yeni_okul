import 'package:baykurs/ui/dashboard/model/mobile_home_response.dart';
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
    String teacherName =
        "${courseModel?.teacher?.user?.name ?? ''} ${courseModel?.teacher?.user?.surname ?? ''}"
            .trim();
    String timeString = courseModel?.startDate != null
        ? DateFormat('HH:mm').format(DateTime.parse(courseModel!.startDate!))
        : '-';
    String formatStartDate(DateTime startDate) {
      String formattedDate = DateFormat('dd.MM.yyyy').format(startDate);
      String formattedTime = DateFormat('HH:mm').format(startDate);
      return '$formattedDate | Saat: $formattedTime';
    }

    String endTime = courseModel?.endDate != null
        ? DateFormat('HH:mm').format(DateTime.parse(courseModel!.endDate!))
        : '-';

    String price = '₺${courseModel?.price ?? 0}';
    final now = DateTime.now();
    final startDate = courseModel?.startDate != null
        ? DateTime.parse(courseModel!.startDate!)
        : null;

    final isWithinOneHour = startDate != null
        ? startDate.difference(now).inMinutes <= 60 && startDate.isAfter(now)
        : false;

    String formatCourseDateRange(DateTime startDate, DateTime endDate) {
      final formattedDate = DateFormat('dd.MM.yyyy').format(startDate);
      final formattedStartTime = DateFormat('HH:mm').format(startDate);
      final formattedEndTime = DateFormat('HH:mm').format(endDate);

      return '$formattedDate / $formattedStartTime - $formattedEndTime';
    }

    String dateRangeText =
        (courseModel?.startDate != null && courseModel?.endDate != null)
            ? formatCourseDateRange(
                DateTime.parse(courseModel!.startDate!),
                DateTime.parse(courseModel!.endDate!),
              )
            : '-';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: HexColor("#F7F9F9"),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 0.5,
            color: HexColor("#222831").withAlpha(60),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: styleBlack14Bold,
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "Kurum: ", style: styleBlack12Bold),
                          TextSpan(
                              text: schoolName, style: styleBlack12Regular),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "Öğretmen: ", style: styleBlack12Bold),
                          TextSpan(
                              text: teacherName, style: styleBlack12Regular),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "Tarih: ", style: styleBlack12Bold),
                          TextSpan(
                              text: dateRangeText, style: styleBlack12Regular),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (courseModel?.topics != null &&
                        courseModel!.topics!.isNotEmpty)
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Konular: ",
                              style: styleBlack12Bold,
                            ),
                            TextSpan(
                              text: courseModel!.topics!
                                  .map((e) => e.name)
                                  .join(" - "),
                              style: styleBlack12Regular,
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            Container(
              width: 32,
              height: double.infinity,
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
