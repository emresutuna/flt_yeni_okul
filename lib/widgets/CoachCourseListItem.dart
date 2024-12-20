import 'package:baykurs/ui/teacherCoach/model/CourseCoachResponse.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../ui/course/model/CourseModel.dart';
import '../util/HexColor.dart';
import '../util/YOColors.dart';
import 'TertiaryButton.dart';

class CoachCourseListItem extends StatelessWidget {
  final CourseCoach? courseModel;
  final Color colors;

  const CoachCourseListItem(
      {super.key, required this.courseModel, required this.colors});

  @override
  Widget build(BuildContext context) {
    String lessonName = courseModel?.lessonName ?? 'Eğitim Koçu';
    String desc =
        courseModel?.description ?? 'Ders açıklama bilgisi bulunamadı';
    String title = courseModel?.title ?? 'Ders Başlığı bulunamadı';
    String classroom = courseModel?.schoolName ?? 'Kurum bilgisi yok';

    /*
    String dateString = courseModel?.startDate != null
        ? DateFormat('dd/MM/yyyy').format(courseModel!.startDate!)
        : 'Tarih bilgisi yok';
    String timeString = courseModel?.startDate != null
        ? DateFormat('HH:mm').format(courseModel!.startDate!)
        : 'Saat bilgisi yok';
    String endTime = courseModel?.startDate != null
        ? DateFormat('HH:mm').format(courseModel!.endDate!)
        : 'Saat bilgisi yok';

    String price = '${courseModel?.price ?? 0} ₺';


     */
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 4.8,
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
                        "İçerik: $desc",
                        style: styleBlack12Regular,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Kurum: $classroom",
                        style: styleBlack12Bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TertiaryButton(
                              width: 10,
                              height: 40,
                              borderRadius: 8,
                              text: "Detayı Gör",
                              textColor: null,
                              onPress: () {
                                // Satın alma işlemi için yapılacaklar
                              },
                            ),
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
                  color: colors,
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
