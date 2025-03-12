import 'dart:ui';

import '../../course/bloc/lesson_bloc.dart';
import '../../course/bloc/lesson_event.dart';
import '../../course/model/course_filter.dart';
import '../model/course_bundle_response.dart';

class CourseBundleManager {
  final LessonBloc lessonBloc;
  final Function(VoidCallback) setState;

  CourseBundleManager({required this.lessonBloc, required this.setState});

  List<CourseBundle> courseList = [];
  int currentPage = 1;
  bool isFetching = false;
  bool hasMoreData = true;
  String query = "";

  void resetPagination() {
    currentPage = 1;
    hasMoreData = true;
  }

  void fetchCourses({required CourseFilter filter, required String searchQuery}) {
    resetPagination();
    query = searchQuery;
    courseList.clear(); // ✅ Clear old data
    lessonBloc.add(FetchCourseBundleWithFilter(courseFilter: filter.copyWith(currentPage: currentPage.toString())));
  }

  void loadMoreCourses(CourseFilter filter) {
    if (!isFetching && hasMoreData) {
      isFetching = true;
      currentPage++;
      lessonBloc.add(FetchCourseBundleWithFilter(courseFilter: filter.copyWith(currentPage: currentPage.toString())));
    }
  }

  void updateCourseList(List<CourseBundle> newItems) {
    final Set<int?> existingIds = courseList.map((e) => e.id).toSet();
    final uniqueItems = newItems.where((item) => !existingIds.contains(item.id));

    courseList.addAll(uniqueItems);

    if (newItems.isEmpty) {
      hasMoreData = false;
    }

    isFetching = false;
    setState(() {});
  }
}
