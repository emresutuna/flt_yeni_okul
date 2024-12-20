import 'package:baykurs/ui/company/model/SchoolFilter.dart';

abstract class SchoolEvent {}

class FetchSchool extends SchoolEvent {}

class ToggleFavorite extends SchoolEvent {
  final int schoolId;

  ToggleFavorite({required this.schoolId});
}

class SearchSchool extends SchoolEvent {
  final SchoolFilter schoolFilter;

  SearchSchool({
    required this.schoolFilter,
  });
}

class FetchSchoolByFilter extends SchoolEvent {
  final String filterType;
  final String filter;

  FetchSchoolByFilter({
    required this.filterType,
    required this.filter,
  });
}
