import 'package:baykurs/ui/filter/FilterLesson.dart';
import 'package:baykurs/widgets/InfoWidget.dart';
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
  late List<Course> courseList;

  List<Course> searchResults = [];
  CourseFilter courseFilter = CourseFilter();


  void onQueryChanged(String query) {
    //servis query isteği at
    setState(() {
      searchResults = courseList.where((item) => item.quota != 0).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<LessonBloc>().add(FetchLesson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Dersler"),
      body: SafeArea(
        child: Column(
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
            BlocBuilder<LessonBloc, LessonState>(builder: (context, state) {
              if (state is LessonStateLoading) {
                return const SkeletonLoading();
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
                              onTap: () async {
                                final filter = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FilterLesson(courseFilter: courseFilter),
                                    fullscreenDialog: true,
                                  ),
                                ) as CourseFilter?;

                                if (filter != null) {
                                  courseFilter = filter;
                                //  fetchCoursesWithFilter(filter);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                margin:
                                    const EdgeInsets.only(left: 0, right: 16),
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
                          child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: courseList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/courseDetail',
                                  arguments: courseList[index].id);
                            },
                            child: CourseListItem(
                              courseModel: courseList[index],
                              colors: HexColor(
                                  courseList[index].lesson!.color ?? "#4A90E2"),
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
            // Altta, sağdan ve soldan margin uygulanmış shimmer
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
              // Sağ ve soldan 16px margin
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity, // Ekranın tamamına genişlik
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
