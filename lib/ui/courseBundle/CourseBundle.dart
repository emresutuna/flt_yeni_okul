import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baykurs/ui/courseBundle/model/CourseBundleResponse.dart';
import 'package:baykurs/ui/filter/FilterLesson.dart';
import 'package:baykurs/widgets/infoWidget/InfoWidget.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import '../../util/GlobalLoading.dart';
import '../../util/HexColor.dart';
import '../../util/YOColors.dart';
import '../../widgets/SearchBar.dart';
import '../course/bloc/LessonBloc.dart';
import '../course/bloc/LessonEvent.dart';
import '../course/bloc/LessonState.dart';
import '../course/model/CourseFilter.dart';
import '../course/model/CourseTypeEnum.dart';
import 'CourseBundleItem.dart';

class CourseBundleListPage extends StatefulWidget {
  const CourseBundleListPage({super.key});

  @override
  State<CourseBundleListPage> createState() => _CourseBundleListPageState();
}

class _CourseBundleListPageState extends State<CourseBundleListPage> {
  late List<CourseBundle> courseList;

  CourseFilter courseFilter = CourseFilter();
  String query = "";

  final ValueNotifier<bool> isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isPageLoading = ValueNotifier<bool>(true);
  final FocusNode _searchFocusNode = FocusNode();

  void onQueryChanged(String query) {
    this.query = query;
    if (query.length > 2) {
      isSearching.value = true;
      context.read<LessonBloc>().add(
            FetchCourseBundleWithFilter(
                courseFilter: courseFilter.copyWith(query: query)),
          );
    }
  }

  void onQueryCleared() {
    query = "";
    isSearching.value = false;
    context.read<LessonBloc>().add(
          FetchCourseBundleWithFilter(
              courseFilter: courseFilter.copyWith(query: query)),
        );
  }

  @override
  void initState() {
    super.initState();
    context.read<LessonBloc>().add(FetchCourseBundle());
  }

  @override
  void dispose() {
    isSearching.dispose();
    isPageLoading.dispose();
    _searchFocusNode.dispose();
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
            if (state is CourseBundleSuccess || state is LessonStateError) {
              isPageLoading.value = false;
              isSearching.value = false;
            }
          },
          child: ValueListenableBuilder<bool>(
            valueListenable: isPageLoading,
            builder: (context, isLoading, child) {
              if (isLoading) {
                return const GlobalFadeAnimation();
              }
              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollStartNotification) {
                    FocusScope.of(context)
                        .unfocus(); // Scroll sırasında focus kaldır
                  }
                  return false;
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, top: 8, right: 16),
                      child: Text(
                        "Yayınlanan kursları incele ve ders programını oluştur.",
                        style: styleBlack12Bold,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: InfoCardWidget(
                        title: "Kurslar",
                        description:
                            "Baykursta bir ders 80 dakika sürer. Tek bir derse katılmak için 'Ders Bul', tüm konuya ulaşmak için 'Kurs Bul' özelliğini kullanabilirsin. İlgili içerik yoksa 'Ders/Kurs Talep Et' seçeneğiyle talepte bulunabilirsin.",
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              YoSearchBar(
                                onQueryChanged: onQueryChanged,
                                onClearCallback: onQueryCleared,
                                focusNode: _searchFocusNode,
                              ),
                              ValueListenableBuilder<bool>(
                                valueListenable: isSearching,
                                builder: (context, value, child) {
                                  return const SizedBox.shrink();
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              final lessonBloc = context.read<LessonBloc>();
                              final filter = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FilterLesson(
                                    courseFilter: courseFilter,
                                    courseTypeEnum:
                                        CourseTypeEnum.COURSE_BUNDLE,
                                  ),
                                  fullscreenDialog: true,
                                ),
                              ) as CourseFilter?;

                              if (filter != null) {
                                courseFilter = filter;
                                lessonBloc.add(
                                  FetchCourseBundleWithFilter(
                                      courseFilter:
                                          courseFilter.copyWith(query: query)),
                                );
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
                        )
                      ],
                    ),
                    Expanded(
                      child: GestureDetector(
                        onPanDown: (_) => _searchFocusNode.unfocus(),
                        child: BlocBuilder<LessonBloc, LessonState>(
                          builder: (context, state) {
                            if (isSearching.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (state is CourseBundleSuccess) {
                              courseList =
                                  state.courseBundleResponse.data?.data ?? [];
                              if (courseList.isEmpty) {
                                return const Center(
                                  child: Text(
                                    'Sonuç bulunamadı.',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                );
                              }
                              return ListView.builder(
                                itemCount: courseList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/courseBundleDetail',
                                          arguments: courseList[index].id);
                                    },
                                    child: CourseBundleItem(
                                      courseModel:
                                          courseList[index].toCourseList(),
                                      colors: HexColor("#4A90E2"),
                                    ),
                                  );
                                },
                              );
                            }
                            return const Center(
                                child: Text('No courses available'));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
