import '../../course/model/CourseModel.dart';
import 'TimeSheetResponse.dart';

extension TimeSheetToCourse on TimeSheet {
  CourseList toCourse() {
    return CourseList(
      id: id,
      title: lesson?.name ?? "Unknown Lesson", // Ders adı CourseList'te title olarak kullanılabilir
      description: "Scheduled lesson in ${classroom ?? 'unknown classroom'}", // Örnek bir açıklama
      startDate: startDate ?? "", // Tarih bilgileri string olarak kullanılıyor
      endDate: endDate ?? "",
      price: price ?? 0, // Price int olarak CourseList modelinde var
      quota: quota ?? 0, // Kontenjan bilgisi
      schoolName: school?.name ?? "Unknown School", // School nesnesinden sadece name alınır
      lessonName: lesson?.name ?? "Unknown Lesson", // Lesson nesnesinden sadece name alınır
    );
  }
}

