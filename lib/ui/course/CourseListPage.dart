import 'package:baykurs/ui/course/model/CourseTypeEnum.dart';
import 'package:baykurs/ui/filter/FilterLesson.dart';
import 'package:baykurs/widgets/infoWidget/InfoWidget.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
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

  void onQueryChanged(String query) {
    this.query = query;
    if (query.length > 2) {
      context.read<LessonBloc>().add(FetchLessonWithFilter(
          courseFilter: courseFilter.copyWith(query: query)));
    }
  }

  void onQueryCleared() {
    query = "";
    context.read<LessonBloc>().add(FetchLessonWithFilter(
        courseFilter: courseFilter.copyWith(query: query)));
  }

  @override
  void initState() {
    super.initState();
    context.read<LessonBloc>().add(FetchLesson());
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Dersler", canGoBack: widget.hasShowBackButton),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
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
                              builder: (context) => FilterLesson(
                                courseFilter: courseFilter,
                                courseTypeEnum: CourseTypeEnum.COURSE,
                              ),
                              fullscreenDialog: true,
                            ),
                          ) as CourseFilter?;

                          if (filter != null) {
                            courseFilter = filter;
                            lessonBloc.add(FetchLessonWithFilter(
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
                      if (state is LessonStateSuccess) {
                        courseList = state.lessonResponse.data?.data ?? [];
                        return Column(
                          children: [
                            Expanded(
                                child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: courseList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context,
                                            rootNavigator:
                                                !widget.hasShowBackButton)
                                        .pushNamed('/courseDetail',
                                            arguments: courseList[index].id);
                                  },
                                  child: CourseListItem(
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

class SkeletonLoading extends StatelessWidget {
  const SkeletonLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 4.8,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < 3; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 20,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 20, // Yükseklik
                  color: Colors.grey[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
