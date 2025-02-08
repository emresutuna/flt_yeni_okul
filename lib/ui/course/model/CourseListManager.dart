import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/LessonBloc.dart';
import '../bloc/LessonEvent.dart';
import 'CourseFilter.dart';
import 'CourseModel.dart';

class CourseListManager {
  final LessonBloc lessonBloc;
  final Function(VoidCallback) setState;

  CourseListManager({required this.lessonBloc, required this.setState});

  List<CourseList> courseList = [];
  int currentPage = 1;
  bool isFetching = false;
  bool hasMoreData = true;
  String query = "";

  void resetPagination() {
    currentPage = 1;
    hasMoreData = true;
  }

  void fetchLessons(
      {required CourseFilter filter, required String searchQuery}) {
    resetPagination();
    query = searchQuery;

    lessonBloc.add(FetchLessonWithFilter(
        courseFilter: filter.copyWith(
            currentPage: currentPage.toString(), query: searchQuery)));
  }

  void loadMoreData(CourseFilter filter) {
    if (!isFetching && hasMoreData) {
      isFetching = true;
      currentPage++;
      lessonBloc.add(FetchLessonWithFilter(
          courseFilter: filter.copyWith(currentPage: currentPage.toString())));
    }
  }

  void updateLessonList(List<CourseList> newItems) {
    final Set<int?> existingIds = courseList.map((e) => e.id).toSet();
    final uniqueItems =
        newItems.where((item) => !existingIds.contains(item.id));

    courseList.addAll(uniqueItems);

    if (newItems.isEmpty) {
      hasMoreData = false;
    }

    isFetching = false;
    setState(() {});
  }
}
