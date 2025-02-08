import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/SchoolBloc.dart';
import '../bloc/SchoolEvent.dart';

import 'SchoolFilter.dart';
import 'SchoolResponse.dart';

class CompanyListManager {
  final SchoolBloc schoolBloc;
  final Function(VoidCallback) setState;

  CompanyListManager({required this.schoolBloc, required this.setState});

  List<SchoolItem> schoolList = [];
  int currentPage = 1;
  bool isFetching = false;
  bool hasMoreData = true;
  String query = "";

  void resetPagination() {
    currentPage = 1;
    hasMoreData = true;
  }

  void fetchSchools({required SchoolFilter filter, required String searchQuery}) {
    resetPagination();
    query = searchQuery;
    schoolList.clear();
    schoolBloc.add(SearchSchool(schoolFilter: filter.copyWith(query: searchQuery, currentPage: currentPage.toString())));
  }

  void loadMoreSchools(SchoolFilter filter) {
    if (!isFetching && hasMoreData) {
      isFetching = true;
      currentPage++;
      schoolBloc.add(SearchSchool(schoolFilter: filter.copyWith(currentPage: currentPage.toString())));
    }
  }

  void updateSchoolList(List<SchoolItem> newItems) {
    final Set<int> existingIds = schoolList.map((e) => e.id).toSet();
    final uniqueItems = newItems.where((item) => !existingIds.contains(item.id));

    schoolList.addAll(uniqueItems);

    if (newItems.isEmpty) {
      hasMoreData = false;
    }

    isFetching = false;
    setState(() {});
  }

  void toggleFavorite(int index) {
    schoolList[index].isFav = !(schoolList[index].isFav ?? false);
    setState(() {});

    schoolBloc.add(ToggleFavorite(schoolId: schoolList[index].id));
  }
}
