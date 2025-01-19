import 'package:baykurs/ui/teacherCoach/model/CourseCoachResponse.dart';
import 'package:flutter/material.dart';
import '../util/HexColor.dart';
import '../util/LessonExtension.dart';
import '../util/YOColors.dart';

class CoachCourseListItem extends StatelessWidget {
  final CourseCoach? courseModel;
  final Color colors;

  const CoachCourseListItem({
    super.key,
    required this.courseModel,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    String lessonName = courseModel?.lesson ?? 'Eğitim Koçu';
    String desc = courseModel?.description ?? 'Ders açıklama bilgisi bulunamadı';
    String title = courseModel?.title ?? 'Ders Başlığı bulunamadı';
    String classroom = courseModel?.schoolName ?? 'Kurum bilgisi yok';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Added padding for better layout
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: styleBlack16Bold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Lesson Name
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: HexColor(
                            BranchesExtension.getColorForBranch(
                                lessonName) ??
                                DEFAULT_LESSON_COLOR),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        lessonName,
                        style: styleWhite12Bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Description
                Text(
                  "İçerik: $desc",
                  style: styleBlack14Regular,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Classroom
                Text(
                  "Kurum: $classroom",
                  style: styleBlack14Bold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),

                // Action Button
                Align(
                  alignment: Alignment.centerLeft, // Ensures alignment
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color5,
                      minimumSize: const Size(100, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/teacherCoachDetail',
                        arguments: courseModel?.teacherId,
                      );
                    },
                    child: Text(
                      "Detayı Gör",
                      style: styleWhite14Bold,
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
