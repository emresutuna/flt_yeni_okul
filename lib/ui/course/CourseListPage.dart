import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yeni_okul/ui/course/bloc/LessonBloc.dart';
import 'package:yeni_okul/ui/course/bloc/LessonEvent.dart';
import 'package:yeni_okul/ui/course/bloc/LessonState.dart';
import 'package:yeni_okul/widgets/CourseListItem.dart';
import '../../util/HexColor.dart';
import '../../util/YOColors.dart';
import '../../widgets/CompanyListFilterBottomSheet.dart';
import '../../widgets/SearchBar.dart';
import '../../widgets/YOText.dart';
import 'model/CourseModel.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  late List<Course> courseList;

  List<Course> searchResults = [];

  void onQueryChanged(String query) {
    //servis query isteği at
    setState(() {
      searchResults = courseList
          .where(
              (item) => item.quota != 0)
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<LessonBloc>().add(FetchLesson());
  }

  List<Color> lessonColors = [
    HexColor("#4A90E2"), // Blue
    HexColor("#FFA500"), // Orange
    HexColor("#6DD6A7"), // Light Green
    HexColor("#E94E77"), // Red
    HexColor("#FFD700"), // Yellow
    HexColor("#8E44AD"), // Purple
    HexColor("#F39C12"), // Pink
    HexColor("#FF6F61"), // Gray
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8),
              child: Row(
                children: [
                  InkWell(
                    child: const Icon(Icons.arrow_back_ios),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "Dersler",
                    style: styleBlack16Bold,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 24),
              child: Text(
                "Lorem ipsum dolar sit amet",
                style: styleBlack12Bold,
                textAlign: TextAlign.start,
              ),
            ),
            BlocBuilder<LessonBloc, LessonState>(builder: (context, state) {
              if (state is LessonStateLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LessonStateSuccess) {
                courseList = state.lessonResponse.data?.courses ?? [];
                return Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 5,
                              child:
                                  YoSearchBar(onQueryChanged: onQueryChanged)),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                showCompanyFilterBottomSheet(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                margin:
                                    const EdgeInsets.only(left: 0, right: 16),
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: color6),
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
                          child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: courseList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, '/courseDetail', arguments:courseList[index].id);

                            },
                            child: CourseListItem(
                              courseModel: courseList[index],
                              colors: HexColor(courseList[index].lesson.color),
                            ),
                          );
                        },
                      )),
                    ],
                  ),
                );
              } else if (state is LessonStateError) {
                return Center(child: Text('Error: ${state.error}'));
              } else {
                return Center(child: Text('No courses available'));
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget courseItem(String firstIcon, String firstLabel, String secondIcon,
      String secondLabel) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          courseLabel(firstIcon, firstLabel),
          courseLabel(secondIcon, secondLabel),
        ],
      ),
    );
  }

  Widget courseLabel(String icon, String label) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Wrap(
        spacing: 12,
        alignment: WrapAlignment.end,
        clipBehavior: Clip.antiAlias,
        crossAxisAlignment: WrapCrossAlignment.end,
        direction: Axis.horizontal,
        verticalDirection: VerticalDirection.up,
        runAlignment: WrapAlignment.end,
        children: [
          const SizedBox(
            width: 4,
          ),
          ListTile(
            isThreeLine: false,
            minLeadingWidth: 0,
            minVerticalPadding: 0,
            dense: true,
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(vertical: -3),
            leading: Image.asset(icon),
            titleAlignment: ListTileTitleAlignment.center,
            title: Transform.translate(
              offset: const Offset(-32, 0),
              child: YoText(
                text: label,
                size: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
