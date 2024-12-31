import 'package:flutter/material.dart';

import '../../util/HexColor.dart';
import '../../util/LessonExtension.dart';
import '../../util/YOColors.dart';
import '../course/model/CourseModel.dart';

class CourseBundleItem extends StatelessWidget {
  final CourseList? courseModel;
  final Color colors;

  const CourseBundleItem({
    super.key,
    required this.courseModel,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    String lessonName = courseModel?.lesson?.name ??
        courseModel?.lessonName ??
        'Ders bilgisi bulunamadı';
    String title = courseModel?.title ?? 'Ders bilgisi bulunamadı';
    String schoolName = courseModel?.schoolName ?? 'Kurum bilgisi yok';
    String teacherName = courseModel?.teacherFormatted ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: double.infinity,
        ),
        child: IntrinsicHeight(
          child: Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 11,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                            "Tarih: ${courseModel?.formattedStartDate ?? ""}",
                            style: styleBlack12Regular,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: ShapeDecoration(
                      color: HexColor(BranchesExtension.getColorForBranch(
                        courseModel?.lesson?.name ??
                            courseModel?.lessonName ??
                            DEFAULT_LESSON_COLOR,
                      ) ?? DEFAULT_LESSON_COLOR),
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
                        child: FittedBox(
                          fit: BoxFit.scaleDown, // Metnin alana sığmasını sağlar
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0, // Üst ve alt boşluk eklendi
                            ),
                            child: Text(
                              lessonName,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: styleWhite12Bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
