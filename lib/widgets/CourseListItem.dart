import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../ui/course/model/CourseModel.dart';
import '../util/HexColor.dart';
import '../util/YOColors.dart';
import 'TertiaryButton.dart';

class CourseListItem extends StatelessWidget {
  final CourseList? courseModel;
  final Color colors;

  const CourseListItem({super.key, required this.courseModel, required this.colors});

  @override
  Widget build(BuildContext context) {
    String lessonName = courseModel?.lesson?.name ?? courseModel?.lessonName??'Ders bilgisi bulunamadı';
    String title = courseModel?.title ?? 'Ders bilgisi bulunamadı';
    String schoolName = courseModel?.schoolName ?? 'Kurum bilgisi yok';
    String teacherName = 'Eğitmen bilgisi bulunamadı';

    String dateString = courseModel?.startDate != null
        ? courseModel!.startDate!
        : 'Tarih bilgisi yok';

    String timeString = courseModel?.startDate != null
        ? DateFormat('HH:mm').format(DateTime.parse(courseModel!.startDate!))
        : 'Saat bilgisi yok';

    String endTime = courseModel?.endDate != null
        ? DateFormat('HH:mm').format(DateTime.parse(courseModel!.endDate!))
        : 'Saat bilgisi yok';

    String price = '${courseModel?.price ?? 0} ₺';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 4.3 ,
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
                        "Tarih: $dateString | Saat: $timeString - $endTime",
                        style: styleBlack12Regular,
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
