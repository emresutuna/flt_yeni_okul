import '../../course/model/course_model.dart';
import 'TimeSheetResponse.dart';

extension TimeSheetToCourse on TimeSheet {
  CourseList toCourse() {
    return CourseList(
        id: id,
        title: lesson?.name ?? "Unknown Lesson",
        description: "Scheduled lesson in ${classroom ?? 'unknown classroom'}",
        startDate: startDate ?? "",
        endDate: endDate ?? "",
        price: price ?? 0.0,
        quota: quota ?? 0,
        schoolName: school?.user?.name ?? "Unknown School",
        lessonName: lesson?.name ?? "Unknown Lesson",
        school: school,
        teacher: teacher);
  }
}
