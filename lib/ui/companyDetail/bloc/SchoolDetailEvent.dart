abstract class SchoolDetailEvent {}


class FetchSchoolById extends SchoolDetailEvent {
  final int id;

  FetchSchoolById({
    required this.id,
  });
}
class ToggleFavorite extends SchoolDetailEvent {
  final int schoolId;

  ToggleFavorite({required this.schoolId});
}