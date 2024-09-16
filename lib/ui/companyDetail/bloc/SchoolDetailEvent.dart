abstract class SchoolDetailEvent {}


class FetchSchoolById extends SchoolDetailEvent {
  final int id;

  FetchSchoolById({
    required this.id,
  });
}