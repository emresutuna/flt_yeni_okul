import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baykurs/ui/course/model/course_type_enum.dart';
import 'package:baykurs/ui/filter/filter_lesson.dart';
import 'package:baykurs/widgets/infoWidget/InfoWidget.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import '../../util/FirebaseAnalyticsConstants.dart';
import '../../util/FirebaseAnalyticsManager.dart';
import '../../util/GlobalLoading.dart';
import '../../util/HexColor.dart';
import '../../util/YOColors.dart';
import '../../widgets/CourseListItem.dart';
import '../../widgets/SearchBar.dart';
import '../coursedetail/model/course_detail_args.dart';
import 'model/course_list_manager.dart';
import 'model/course_list_notifier.dart';
import 'bloc/lesson_bloc.dart';
import 'bloc/lesson_state.dart';
import 'model/course_filter.dart';

class CourseListPage extends StatefulWidget {
  final bool hasShowBackButton;

  const CourseListPage({super.key, required this.hasShowBackButton});

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  late CourseListManager courseListManager;
  final CourseListNotifier notifier = CourseListNotifier();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _searchFocusNode = FocusNode();
  CourseFilter courseFilter = CourseFilter();
  Timer? _searchDebounce;

  void _onSearchChangedWithDebounce(String query) {
    if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      _onSearchChanged(query);
    });
  }

  void _onSearchCleared() {
    setState(() {
      notifier.setLoading(true);
      courseListManager.resetPagination();
      courseListManager.courseList.clear();
    });

    courseListManager.fetchLessons(filter: courseFilter, searchQuery: "");
  }

  @override
  void initState() {
    super.initState();
    courseListManager = CourseListManager(
        lessonBloc: context.read<LessonBloc>(), setState: setState);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleInitialFilter();
    });

    _scrollController.addListener(_onScroll);
  }

  void _handleInitialFilter() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is int) {
      courseFilter = courseFilter.copyWith(schoolId: args);
    }
    courseListManager.fetchLessons(filter: courseFilter, searchQuery: "");
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      courseListManager.loadMoreData(courseFilter);
    }
  }

  void _onSearchChanged(String query) {
    if (query.length < 3) return;

    setState(() {
      notifier.setLoading(true);
      courseListManager.resetPagination();
      courseListManager.courseList.clear();
    });

    FirebaseAnalyticsManager.logEvent(FirebaseAnalyticsConstants.course_search);

    courseListManager.fetchLessons(
        filter: courseFilter.copyWith(query: query), searchQuery: query);
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
      appBar: WhiteAppBar("Dersler", canGoBack: widget.hasShowBackButton),
      body: SafeArea(
        child: BlocListener<LessonBloc, LessonState>(
          listener: (context, state) {
            if (state is LessonStateSuccess) {
              courseListManager
                  .updateLessonList(state.lessonResponse.data?.data ?? []);
              notifier.setLoading(false);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildSearchBar(),
              Expanded(
                child: ListenableBuilder(
                  listenable: notifier,
                  builder: (context, child) {
                    return notifier.isPageLoading
                        ? const GlobalFadeAnimation()
                        : _buildCourseList();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFilterChange(CourseFilter newFilter) {
    setState(() {
      notifier.setLoading(true);
      courseFilter = newFilter;
      courseListManager.resetPagination();
      courseListManager.courseList.clear();
    });

    courseListManager.fetchLessons(
        filter: courseFilter, searchQuery: courseListManager.query);
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Yayınlanan dersleri incele ve ders programını oluştur.",
            style: styleBlack12Bold,
            textAlign: TextAlign.start,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: InfoCardWidget(
              title: "Dersler",
              description:
                  "Baykursta bir ders 80 dakika sürer. Tek bir derse katılmak için 'Ders Bul', tüm konuya ulaşmak için 'Kurs Bul' özelliğini kullanabilirsin. İlgili içerik yoksa 'Ders/Kurs Talep Et' seçeneğiyle talepte bulunabilirsin.",
            ),
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
            FirebaseAnalyticsManager.logEvent(
                FirebaseAnalyticsConstants.course_filter);
            final filter = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FilterLesson(
                  courseFilter: courseFilter,
                  courseTypeEnum: CourseTypeEnum.course,
                ),
                fullscreenDialog: true,
              ),
            ) as CourseFilter?;

            if (filter != null) {
              courseFilter = filter;
              _handleFilterChange(filter);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(left: 0, right: 16),
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
    if (courseListManager.courseList.isEmpty) {
      return const Center(
          child:
              Text('Aktif ders bulunamadı.', style: TextStyle(fontSize: 16)));
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: courseListManager.courseList.length,
      itemBuilder: (context, index) {
        final course = courseListManager.courseList[index];
        return InkWell(
          onTap: () {
            FirebaseAnalyticsManager.logEvent(
              FirebaseAnalyticsConstants.course_detail_click,
              parameters: {
                "lesson": course.lesson?.name ?? course.lessonName ?? "",
                "schoolName": course.schoolName ?? "Kurum bilgisi yok"
              },
            );
            Navigator.of(context, rootNavigator: !widget.hasShowBackButton)
                .pushNamed('/courseDetail',
                    arguments: CourseDetailArgs(
                        courseId: course.id ?? 0, isIncomingLesson: false));
          },
          child:
              CourseListItem(courseModel: course, colors: HexColor("#4A90E2")),
        );
      },
    );
  }
}
