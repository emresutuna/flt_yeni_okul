import '../../course/model/CourseTypeEnum.dart';
import '../../courseBundleDetail/model/CourseBundleDetailResponse.dart';
import '../../coursedetail/model/CourseDetailResponseModel.dart';

class PaymentPreview {
  final int? id;
  final CourseTypeEnum? courseType;
  final String? title;
  final String? desc;
  final String? price;
  final String? teacherName;
  final String? schoolName;
  final String? classroom;
  final String? startDate;
  final String? endDate;
  final String? lessonName;

  PaymentPreview({
    required this.title,
    required this.id,
    required this.courseType,
    required this.desc,
    required this.price,
    required this.teacherName,
    required this.schoolName,
    required this.classroom,
    required this.startDate,
    required this.endDate,
    required this.lessonName,
  });

  factory PaymentPreview.fromObject(dynamic source) {
    if (source is CourseDetailData) {
      return PaymentPreview(
          id: source.id,
          courseType: mapCourseType(source.courseType ?? 0),
          title: source.title,
          desc: source.description,
          price: _convertToString(source.price),
          teacherName: source.teacherFormatted,
          startDate: source.formattedStartDate,
          classroom: source.classroom,
          endDate: source.formattedEndDate,
          lessonName:
              source.lesson?.name ?? source.lessonName ?? "Ders bulunamadı",
          schoolName: source.formattedSchool);
    } else if (source is CourseBundleData) {
      return PaymentPreview(
          id: source.id,
          courseType: CourseTypeEnum.COURSE_BUNDLE,
          title: source.title,
          desc: source.description,
          price: _convertToString(source.price),
          teacherName: source.courses.first.teacherFormatted,
          lessonName:
              source.courses.first.lesson?.name ?? source.courses.first.lessonName ?? "Ders bulunamadı",
          schoolName: source.courses.first.formattedSchool,
          classroom: source.courses.first.classroom,
          startDate: source.courses.first.formattedStartDate,
          endDate: source.courses.first.formattedEndDate);
    } else {
      throw ArgumentError('Unsupported type for PaymentPreview mapping');
    }
  }

  static String? _convertToString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }
}
