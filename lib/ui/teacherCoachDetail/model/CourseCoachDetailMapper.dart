import 'CourseCoachDetailResponse.dart';
import 'CourseCoachUiModel.dart';

CourseCoachDetailUiModel mapToUiModel(CourseCoachDetail entity) {
  return CourseCoachDetailUiModel(
    id: entity.id ?? 0,
    price: entity.price ?? 0,
    course: entity.course != null
        ? CourseUiModel.fromEntity(entity.course!)
        : CourseUiModel.defaultModel(),
    title: entity.title ?? "No Title",
    description: entity.description ?? "No Description",
  );
}