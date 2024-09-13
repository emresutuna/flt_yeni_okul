abstract class SchoolEvent {}

class FetchSchool extends SchoolEvent {}

class FetchSchoolByFilter extends SchoolEvent {
  final String filterType;
  final String filter;

  FetchSchoolByFilter({
    required this.filterType,
    required this.filter,
  });
}
