import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baykurs/ui/filter/FilterLesson.dart';
import 'package:baykurs/ui/teacherCoach/model/CourseCoachResponse.dart';
import 'package:baykurs/widgets/infoWidget/InfoWidget.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import '../../util/HexColor.dart';
import '../../util/YOColors.dart';
import '../../widgets/CoachCourseListItem.dart';
import '../../widgets/SearchBar.dart';
import '../course/bloc/LessonBloc.dart';
import '../course/bloc/LessonEvent.dart';
import '../course/bloc/LessonState.dart';
import '../course/model/CourseFilter.dart';
import '../course/model/CourseTypeEnum.dart';

class TeacherCoach extends StatefulWidget {
  const TeacherCoach({super.key});

  @override
  State<TeacherCoach> createState() => _TeacherCoachState();
}

class _TeacherCoachState extends State<TeacherCoach> {
  late List<CourseCoach> courseList;

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
            FetchCourseCoachWithFilter(
                courseFilter: courseFilter.copyWith(query: query)),
          );
    }
  }

  void onQueryCleared() {
    query = "";
    isSearching.value = false;
    context.read<LessonBloc>().add(
          FetchCourseCoachWithFilter(
              courseFilter: courseFilter.copyWith(query: query)),
        );
  }

  @override
  void initState() {
    super.initState();
    context.read<LessonBloc>().add(FetchCourseCoach());
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
      appBar: WhiteAppBar("Eğitim Koçu"),
      body: SafeArea(
        child: BlocListener<LessonBloc, LessonState>(
          listener: (context, state) {
            if (state is CourseCoachSuccess || state is LessonStateError) {
              isPageLoading.value = false;
              isSearching.value = false;
            }
          },
          child: ValueListenableBuilder<bool>(
            valueListenable: isPageLoading,
            builder: (context, isLoading, child) {
              if (isLoading) {
                return Center(
                  child: CircularProgressIndicator(color: color5),
                );
              }
              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollStartNotification) {
                    FocusScope.of(context)
                        .unfocus();
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
                        "Bu hafta yayınlanan dersleri incele ve haftalık programını oluştur.",
                        style: styleBlack12Bold,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: InfoCardWidget(
                        title: "Dersler",
                        description:
                            "Dersin verildiği kurum ve ders hakkında detayları inceleyebilir, dersi satın alabilirsin. Dilersen, üst menüden seçim yaparak sadece favori kurumlarının yayınladığı dersleri görüntüleyebilirsin. Almak istediğin ders yayında yoksa Ders/Kurs Talep Et özelliğini kullanabilirsin.",
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
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
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final lessonBloc = context.read<LessonBloc>();
                              final filter = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FilterLesson(
                                    courseFilter: courseFilter,
                                    courseTypeEnum: CourseTypeEnum.COURSE_COACH,
                                  ),
                                  fullscreenDialog: true,
                                ),
                              ) as CourseFilter?;

                              if (filter != null) {
                                courseFilter = filter;
                                lessonBloc.add(
                                  FetchCourseCoachWithFilter(
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
                              return  Center(
                                child: CircularProgressIndicator(color: color5,),
                              );
                            }

                            if (state is CourseCoachSuccess) {
                              courseList = state.courseCoachResponse.data
                                      ?.courseCoachList ??
                                  [];
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
                                    onTap: (){
                                      Navigator.pushNamed(
                                          context, '/teacherCoachDetail',
                                          arguments: courseList[index].teacherId);
                                    },
                                    child: CoachCourseListItem(
                                      courseModel: courseList[index],
                                      colors: HexColor("4A90E2"),
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
