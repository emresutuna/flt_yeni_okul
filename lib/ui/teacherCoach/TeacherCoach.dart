import 'dart:async';
import 'package:baykurs/util/GlobalLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baykurs/widgets/infoWidget/InfoWidget.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import '../../util/FirebaseAnalyticsConstants.dart';
import '../../util/FirebaseAnalyticsManager.dart';
import '../../util/HexColor.dart';
import '../../util/YOColors.dart';
import '../../widgets/SearchBar.dart';
import '../../widgets/CoachCourseListItem.dart';
import '../course/bloc/lesson_bloc.dart';
import '../course/bloc/lesson_state.dart';
import '../course/model/course_filter.dart';
import '../course/model/course_type_enum.dart';
import '../filter/filter_lesson.dart';
import 'model/TeacherCoachManager.dart';
import 'model/TeacherCoachNotifier.dart';

class TeacherCoach extends StatefulWidget {
  const TeacherCoach({super.key});

  @override
  State<TeacherCoach> createState() => _TeacherCoachState();
}

class _TeacherCoachState extends State<TeacherCoach> {
  late TeacherCoachManager teacherCoachManager;
  final TeacherCoachNotifier notifier = TeacherCoachNotifier();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _searchFocusNode = FocusNode();
  CourseFilter courseFilter = CourseFilter();
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    teacherCoachManager = TeacherCoachManager(
      lessonBloc: context.read<LessonBloc>(),
      setState: setState,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialData();
    });

    _scrollController.addListener(_onScroll);
  }

  void _fetchInitialData() {
    teacherCoachManager.fetchCourses(filter: courseFilter, searchQuery: "");
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      teacherCoachManager.loadMoreCourses(courseFilter);
    }
  }

  void _onSearchChangedWithDebounce(String query) {
    if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      _onSearchChanged(query);
    });
  }

  void _onSearchChanged(String query) {
    if (query.length < 3) return;

    setState(() {
      notifier.setLoading(true);
      teacherCoachManager.resetPagination();
      teacherCoachManager.courseList.clear();
    });

    FirebaseAnalyticsManager.logEvent(FirebaseAnalyticsConstants.course_search);
    teacherCoachManager.fetchCourses(filter: courseFilter, searchQuery: query);
  }

  void _onSearchCleared() {
    setState(() {
      notifier.setLoading(true);
      teacherCoachManager.resetPagination();
      teacherCoachManager.courseList.clear();
    });

    teacherCoachManager.fetchCourses(filter: courseFilter, searchQuery: "");
  }

  void _handleFilterChange(CourseFilter newFilter) {
    setState(() {
      notifier.setLoading(true);
      courseFilter = newFilter;
      teacherCoachManager.resetPagination();
      teacherCoachManager.courseList.clear();
    });

    teacherCoachManager.fetchCourses(filter: courseFilter, searchQuery: teacherCoachManager.query);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchFocusNode.dispose();
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Eğitim Koçu"),
      body: SafeArea(
        child: BlocListener<LessonBloc, LessonState>(
          listener: (context, state) {
            if (state is CourseCoachSuccess) {
              teacherCoachManager.updateCourseList(state.courseCoachResponse.data?.courseCoachList ?? []);
              notifier.setLoading(false);
            }
          },
          child: Column(
            children: [
              _buildHeader(),
              _buildSearchBar(),
              Expanded(
                child: ListenableBuilder(
                  listenable: notifier,
                  builder: (context, child) {
                    return _buildCourseList();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Çevreni profesyonellerle donat!",
            style: styleBlack12Bold,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 8),
          const InfoCardWidget(
            title: "Eğitim Koçu",
            description: "Eğitim koçlarını inceleyerek en uygun profesyonelden 1 saatlik özel randevu alabilirsin.",
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: YoSearchBar(
            onQueryChanged: _onSearchChangedWithDebounce,
            onClearCallback: _onSearchCleared,
            focusNode: _searchFocusNode,
          ),
        ),
        InkWell(
          onTap: () async {
            final filter = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FilterLesson(
                  courseFilter: courseFilter,
                  courseTypeEnum: CourseTypeEnum.courseCoach,
                ),
                fullscreenDialog: true,
              ),
            ) as CourseFilter?;

            if (filter != null) {
              _handleFilterChange(filter);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(left: 8, right: 16),
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color5,
            ),
            child: Image.asset("assets/ic_filter.png"),
          ),
        ),

      ],
    );
  }

  Widget _buildCourseList() {
    if (notifier.isPageLoading) {
      return const Center(child: GlobalFadeAnimation());
    }

    if (teacherCoachManager.courseList.isEmpty) {
      return const Center(child: Text('Aktif ders bulunamadı.', style: TextStyle(fontSize: 16)));
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: teacherCoachManager.courseList.length,
      itemBuilder: (context, index) {
        final course = teacherCoachManager.courseList[index];
        return CoachCourseListItem(courseModel: course, colors: HexColor("#4A90E2"));
      },
    );
  }
}
