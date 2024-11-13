import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../util/HexColor.dart';
import '../../util/SharedPrefHelper.dart';
import '../../util/YOColors.dart';
import '../../widgets/CourseListItem.dart';
import '../../widgets/QuickAction.dart';
import '../course/model/CourseModel.dart';
import '../model/QuickActionModel.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  CarouselController buttonCarouselController = CarouselController();
  List<QuickActionModel> quickActionList = [
    QuickActionModel(name: "Ders Programı", icon: "assets/ic_time_sheet.png"),
    QuickActionModel(name: "Ders Bul", icon: "assets/ic_find_course.png"),
    QuickActionModel(name: "Kurum Bul", icon: "assets/ic_find_school.png"),
    QuickActionModel(
        name: "Ders Talep Et", icon: "assets/ic_request_course.png"),
    QuickActionModel(name: "Eğitim Koçu", icon: "assets/ic_training_coach.png"),
    QuickActionModel(name: "Deneme Kulubü", icon: "assets/ic_trial_club.png"),
  ];
  List<Course> courseList = [
    Course(
      id: 1,
      schoolId: 6,
      lessonId: 1,
      teacherId: 25,
      startDate: DateTime.parse("2024-10-24T12:00:00.000000Z"),
      endDate: DateTime.parse("2024-10-24T13:00:00.000000Z"),
      classroom: "Sed doloribus omnis totam.",
      deadline: DateTime.parse("2024-10-24T00:00:00.000000Z"),
      price: 225.0,
      quota: 28,
      createdAt: DateTime.parse("2024-10-16T01:50:31.000000Z"),
      updatedAt: DateTime.parse("2024-10-16T01:50:31.000000Z"),
      deletedAt: "null",
      school: School(
        id: 6,
        userId: 6,
        user: User(
          id: 6,
          name: "FAKE_SCHOOL_Mrs. Graciela Murazik MD",
        ),
      ),
      lesson: Lesson(
        id: 1,
        name: "Matematik",
        color: "#4A90E2",
      ),
      teacher: Teacher(
        id: 25,
        userId: 35,
        user: User(
          id: 35,
          name: "FAKE_TEACHER_Dr. Julianne Botsford",
        ),
      ),
    ),
    Course(
      id: 2,
      schoolId: 3,
      lessonId: 1,
      teacherId: 16,
      startDate: DateTime.parse("2024-10-22T12:00:00.000000Z"),
      endDate: DateTime.parse("2024-10-22T13:00:00.000000Z"),
      classroom: "Labore et quibusdam voluptas.",
      deadline: DateTime.parse("2024-10-22T00:00:00.000000Z"),
      price: 145.0,
      quota: 20,
      createdAt: DateTime.parse("2024-10-16T01:50:31.000000Z"),
      updatedAt: DateTime.parse("2024-10-16T01:50:31.000000Z"),
      deletedAt: "",
      school: School(
        id: 3,
        userId: 3,
        user: User(
          id: 3,
          name: "FAKE_SCHOOL_Mrs. Adriana Toy DVM",
        ),
      ),
      lesson: Lesson(
        id: 1,
        name: "Matematik",
        color: "#4A90E2",
      ),
      teacher: Teacher(
        id: 16,
        userId: 26,
        user: User(
          id: 26,
          name: "FAKE_TEACHER_Mohamed Reinger",
        ),
      ),
    ),
    Course(
      id: 3,
      schoolId: 9,
      lessonId: 6,
      teacherId: 15,
      startDate: DateTime.parse("2024-10-22T12:00:00.000000Z"),
      endDate: DateTime.parse("2024-10-22T13:00:00.000000Z"),
      classroom: "Saepe rerum natus et.",
      deadline: DateTime.parse("2024-10-22T00:00:00.000000Z"),
      price: 119.0,
      quota: 17,
      createdAt: DateTime.parse("2024-10-16T01:50:31.000000Z"),
      updatedAt: DateTime.parse("2024-10-16T01:50:31.000000Z"),
      deletedAt: "null",
      school: School(
        id: 9,
        userId: 9,
        user: User(
          id: 9,
          name: "FAKE_SCHOOL_Brooklyn Bogisich",
        ),
      ),
      lesson: Lesson(
        id: 6,
        name: "Geometri",
        color: "#8E44AD",
      ),
      teacher: Teacher(
        id: 15,
        userId: 25,
        user: User(
          id: 25,
          name: "FAKE_TEACHER_Troy Hermiston PhD",
        ),
      ),
    ),
  ];
  late Future<String?> userNameFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the future to read user name
    userNameFuture = readData("user_name");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<String?>(
          future: userNameFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final userName = snapshot.data;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      height: 200.0,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: false,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.2,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: [1, 2, 3, 4, 5].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'text $i',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16),
                    child: Text(
                      "Kolay İşlemler",
                      style: styleBlack16Bold,
                    ),
                  ),
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: quickActionList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 0,
                            childAspectRatio: 1.1),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        if (index == 2) {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed("/companyList");
                        }
                        if (index == 0) {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed("/timeSheetPage");
                        }
                        if (index == 1) {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed("/courseListPage");
                        }
                        if (index == 3) {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed("/requestLessonPage");
                        }
                        if (index == 4) {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed("/teacherCoach");
                        }
                        if (index == 5) {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed("/userEditSelection");
                        }
                      },
                      child: QuickAction(
                        icon: quickActionList[index].icon,
                        name: quickActionList[index].name,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, bottom: 8, left: 16),
                    child: Text(
                      "Yaklaşan Derslerin",
                      style: styleBlack16Bold,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, bottom: 8, left: 16),
                    child: Text(
                      "İlgilenecebileceğin Dersler",
                      style: styleBlack16Bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 4.4,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: courseList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.96,
                            child: CourseListItem(
                              courseModel: courseList[index],
                              colors:
                                  HexColor(courseList[index].lesson!.color!),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}