import '../../course/model/CourseModel.dart';
import 'TimeSheetResponse.dart';

extension TimeSheetToCourse on TimeSheet {
  Course toCourse() {
    return Course(
      id: id ?? 0,
      schoolId: schoolId ?? 0,
      lessonId: lessonId ?? 0,
      teacherId: teacherId ?? 0,
      startDate: DateTime.parse(startDate ?? DateTime.now().toString()),
      endDate: DateTime.parse(endDate ?? DateTime.now().toString()),
      classroom: classroom ?? '',
      deadline: DateTime.parse(deadline ?? DateTime.now().toString()),
      price: price?.toDouble() ?? 0.0,
      quota: quota ?? 0,
      createdAt: DateTime.parse(createdAt ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(updatedAt ?? DateTime.now().toString()),
      deletedAt: deletedAt?? "",
      school: school ?? School(id: 0, userId: 0, user: User(id: 0, name: "")),
      lesson: lesson ?? Lesson(id: 0, name: 'Unknown Lesson', color: '#FFFFFF'),
      teacher: teacher ?? Teacher(id: 0,  userId: 1, user: User(id: 0,name: "")),
    );
  }
}
