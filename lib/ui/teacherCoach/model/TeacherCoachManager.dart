import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../course/bloc/LessonBloc.dart';
import '../../course/bloc/LessonEvent.dart';
import '../../course/model/CourseFilter.dart';
import 'CourseCoachResponse.dart';

class TeacherCoachManager {
  final LessonBloc lessonBloc;
  final Function(VoidCallback) setState;

  TeacherCoachManager({required this.lessonBloc, required this.setState});

  List<CourseCoach> courseList = [];
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
    courseList.clear();
    lessonBloc.add(FetchCourseCoachWithFilter(courseFilter: filter.copyWith(query: searchQuery,currentPage: currentPage.toString())));
  }

  void loadMoreCourses(CourseFilter filter) {
    if (!isFetching && hasMoreData) {
      isFetching = true;
      currentPage++;
      lessonBloc.add(FetchCourseCoachWithFilter(courseFilter: filter.copyWith(currentPage: currentPage.toString())));
    }
  }

  void updateCourseList(List<CourseCoach> newItems) {
    final Set<int?> existingIds = courseList.map((e) => e.teacherId).toSet();
    final uniqueItems = newItems.where((item) => !existingIds.contains(item.teacherId));

    courseList.addAll(uniqueItems);

    if (newItems.isEmpty) {
      hasMoreData = false;
    }

    isFetching = false;
    setState(() {});
  }
}
