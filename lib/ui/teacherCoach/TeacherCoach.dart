import 'package:baykurs/ui/filter/FilterLesson.dart';
import 'package:baykurs/ui/teacherCoach/model/CourseCoachResponse.dart';
import 'package:baykurs/widgets/InfoWidget.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../util/HexColor.dart';
import '../../util/YOColors.dart';
import '../../widgets/CoachCourseListItem.dart';
import '../../widgets/SearchBar.dart';
import '../course/bloc/LessonBloc.dart';
import '../course/bloc/LessonEvent.dart';
import '../course/bloc/LessonState.dart';
import '../course/model/CourseFilter.dart';

class TeacherCoach extends StatefulWidget {
  const TeacherCoach({super.key});

  @override
  State<TeacherCoach> createState() => _TeacherCoachState();
}

class _TeacherCoachState extends State<TeacherCoach> {
  late List<CourseCoach> courseList;

  CourseFilter courseFilter = CourseFilter();
  String query = "";

  void onQueryChanged(String query) {
    this.query = query;
    if (query.length > 2) {
      context.read<LessonBloc>().add(FetchCourseCoachWithFilter(
          courseFilter: courseFilter.copyWith(query: query)));
    }
  }

  void onQueryCleared() {
    query = "";
    context.read<LessonBloc>().add(FetchCourseCoachWithFilter(
        courseFilter: courseFilter.copyWith(query: query)));
  }

  @override
  void initState() {
    super.initState();
    context.read<LessonBloc>().add(FetchCourseCoach());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Eğitim Koçu"),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 24),
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
                          "Dersin verildiği kurum ve ders hakkında detayları inceleyebilir, dersi satın alabilirsin. Dilersen, üst menüden seçim yaparak sadece favori kurumlarının yayınladığı dersleri görüntüleyebilirsin. Almak istediğin ders yayında yoksa Ders Talep Et özelliğini kullanabilirsin."),
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: YoSearchBar(
                          onQueryChanged: onQueryChanged,
                          onClearCallback: onQueryCleared,
                        )),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          final lessonBloc = context.read<LessonBloc>();
                          final filter = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FilterLesson(courseFilter: courseFilter),
                              fullscreenDialog: true,
                            ),
                          ) as CourseFilter?;

                          if (filter != null) {
                            courseFilter = filter;
                            lessonBloc.add(FetchCourseCoachWithFilter(
                                courseFilter:
                                    courseFilter.copyWith(query: query)));
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(left: 0, right: 16),
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: color5),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Image.asset(
                              "assets/ic_filter.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: BlocBuilder<LessonBloc, LessonState>(
                    builder: (context, state) {
                      if (state is CourseCoachSuccess) {
                        courseList =
                            state.courseCoachResponse.data?.courseCoachList ??
                                [];
                        return Column(
                          children: [
                            Expanded(
                                child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: courseList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/teacherCoachDetail',
                                        arguments: courseList[index].id);
                                  },
                                  child: CoachCourseListItem(
                                    courseModel: courseList[index],
                                    colors: HexColor("#4A90E2"),
                                  ),
                                );
                              },
                            )),
                          ],
                        );
                      } else if (state is LessonStateError) {
                        return Center(child: Text('Error: ${state.error}'));
                      } else {
                        return Center(child: Text('No courses available'));
                      }
                    },
                  ),
                ),
              ],
            ),
            BlocBuilder<LessonBloc, LessonState>(
              builder: (context, state) {
                if (state is LessonStateLoading) {
                  return Container(
                    color: Colors.black54, // Semi-transparent background
                    child: const Center(
                      child: CircularProgressIndicator(), // Loading spinner
                    ),
                  );
                }
                return SizedBox.shrink(); // Invisible widget when not loading
              },
            ),
          ],
        ),
      ),
    );
  }
}
