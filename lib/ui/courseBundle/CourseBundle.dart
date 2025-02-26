import 'dart:async';
import 'package:baykurs/util/GlobalLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baykurs/ui/filter/FilterLesson.dart';
import 'package:baykurs/widgets/infoWidget/InfoWidget.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import '../../util/FirebaseAnalyticsConstants.dart';
import '../../util/FirebaseAnalyticsManager.dart';
import '../../util/HexColor.dart';
import '../../util/YOColors.dart';
import '../../widgets/SearchBar.dart';
import 'CourseBundleItem.dart';
import '../course/bloc/LessonBloc.dart';
import '../course/bloc/LessonState.dart';
import '../course/model/CourseFilter.dart';
import '../course/model/CourseTypeEnum.dart';
import 'model/CourseBundleManager.dart';
import 'model/CourseBundleNotifier.dart';

class CourseBundleListPage extends StatefulWidget {
  const CourseBundleListPage({super.key});

  @override
  State<CourseBundleListPage> createState() => _CourseBundleListPageState();
}

class _CourseBundleListPageState extends State<CourseBundleListPage> {
  late CourseBundleManager courseBundleManager;
  final CourseBundleNotifier notifier = CourseBundleNotifier();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _searchFocusNode = FocusNode();
  CourseFilter courseFilter = CourseFilter();
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    courseBundleManager = CourseBundleManager(
      lessonBloc: context.read<LessonBloc>(),
      setState: setState,
    );

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
    courseBundleManager.fetchCourses(filter: courseFilter, searchQuery: "");
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      courseBundleManager.loadMoreCourses(courseFilter);
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
      courseBundleManager.resetPagination();
      courseBundleManager.courseList.clear();
    });

    FirebaseAnalyticsManager.logEvent(FirebaseAnalyticsConstants.course_search);
    courseBundleManager.fetchCourses(filter: courseFilter.copyWith(query: query), searchQuery: query);
  }

  void _onSearchCleared() {
    setState(() {
      notifier.setLoading(true);
      courseBundleManager.resetPagination();
      courseBundleManager.courseList.clear();
    });

    courseBundleManager.fetchCourses(filter: courseFilter, searchQuery: "");
  }

  void _handleFilterChange(CourseFilter newFilter) {
    setState(() {
      notifier.setLoading(true);
      courseFilter = newFilter;
      courseBundleManager.resetPagination();
      courseBundleManager.courseList.clear();
    });

    courseBundleManager.fetchCourses(filter: courseFilter, searchQuery: "");
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
      appBar: WhiteAppBar("Kurslar"),
      body: SafeArea(
        child: BlocListener<LessonBloc, LessonState>(
          listener: (context, state) {
            if (state is CourseBundleSuccess) {
              courseBundleManager.updateCourseList(
                  state.courseBundleResponse.data?.data ?? []);
              notifier.setLoading(false);
            }
          },
          child: Column(
            children: [
              _buildHeader(), // ✅ Top section (InfoBox & Filter Button)
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

  /// 🔹 **Header with Info Box & Filter Button**
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Yayınlanan kursları incele ve ders programını oluştur.",
            style: styleBlack12Bold,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 8),
          const InfoCardWidget(
            title: "Kurslar",
            description:
                "Baykursta bir ders 80 dakika sürer. Tek bir derse katılmak için 'Ders Bul', tüm konuya ulaşmak için 'Kurs Bul' özelliğini kullanabilirsin. İlgili içerik yoksa 'Ders/Kurs Talep Et' seçeneğiyle talepte bulunabilirsin.",
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
                  courseTypeEnum: CourseTypeEnum.COURSE_BUNDLE,
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
    if (notifier.isPageLoading) {
      return const Center(child: GlobalFadeAnimation());
    }

    if (courseBundleManager.courseList.isEmpty) {
      return const Center(
          child:
              Text('Aktif kurs bulunamadı.', style: TextStyle(fontSize: 16)));
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: courseBundleManager.courseList.length,
      itemBuilder: (context, index) {
        final course = courseBundleManager.courseList[index];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
                context, '/courseBundleDetail',
                arguments: course.id);
          },
          child: CourseBundleItem(
              courseModel: course.toCourseList(), colors: HexColor("#4A90E2")),
        );
      },
    );
  }
}
