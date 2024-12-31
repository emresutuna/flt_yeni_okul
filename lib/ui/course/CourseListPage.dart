import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baykurs/ui/course/model/CourseTypeEnum.dart';
import 'package:baykurs/ui/filter/FilterLesson.dart';
import 'package:baykurs/widgets/infoWidget/InfoWidget.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import '../../util/HexColor.dart';
import '../../util/YOColors.dart';
import '../../widgets/CourseListItem.dart';
import '../../widgets/SearchBar.dart';
import 'bloc/LessonBloc.dart';
import 'bloc/LessonEvent.dart';
import 'bloc/LessonState.dart';
import 'model/CourseFilter.dart';
import 'model/CourseModel.dart';

class CourseListPage extends StatefulWidget {
  final bool hasShowBackButton;

  const CourseListPage({super.key, required this.hasShowBackButton});

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  late List<CourseList> courseList;

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
        FetchLessonWithFilter(courseFilter: courseFilter.copyWith(query: query)),
      );
    }
  }

  void onQueryCleared() {
    query = "";
    isSearching.value = false;
    context.read<LessonBloc>().add(
      FetchLessonWithFilter(courseFilter: courseFilter.copyWith(query: query)),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<LessonBloc>().add(FetchLesson());
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
      appBar: WhiteAppBar("Dersler", canGoBack: widget.hasShowBackButton),
      body: SafeArea(
        child: BlocListener<LessonBloc, LessonState>(
          listener: (context, state) {
            if (state is LessonStateSuccess || state is LessonStateError) {
              isPageLoading.value = false;
              isSearching.value = false;
            }
          },
          child: ValueListenableBuilder<bool>(
            valueListenable: isPageLoading,
            builder: (context, isLoading, child) {
              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollStartNotification) {
                    FocusScope.of(context).unfocus(); // Focus'u kaldır
                  }
                  return false;
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 8, right: 16),
                      child: Text(
                        "Yayılanan dersleri incele ve ders programını oluştur.",
                        style: styleBlack12Bold,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: InfoCardWidget(
                        title: "Dersler",
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
                                  return value
                                      ? const Padding(
                                    padding: EdgeInsets.only(right: 16.0),
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                      : const SizedBox.shrink();
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
                                    courseTypeEnum: CourseTypeEnum.COURSE,
                                  ),
                                  fullscreenDialog: true,
                                ),
                              ) as CourseFilter?;

                              if (filter != null) {
                                courseFilter = filter;
                                lessonBloc.add(
                                  FetchLessonWithFilter(
                                      courseFilter: courseFilter.copyWith(query: query)),
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
                            if (state is LessonStateSuccess) {
                              courseList = state.lessonResponse.data?.data ?? [];
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
                                  return CourseListItem(
                                    courseModel: courseList[index],
                                    colors: HexColor("#4A90E2"),
                                  );
                                },
                              );
                            }
                            return const Center(child: Text('No courses available'));
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
