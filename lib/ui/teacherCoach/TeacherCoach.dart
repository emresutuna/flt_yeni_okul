import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/HexColor.dart';
import '../../util/YOColors.dart';
import '../../widgets/CompanyListFilterBottomSheet.dart';
import '../../widgets/CourseListItem.dart';
import '../../widgets/InfoWidget.dart';
import '../../widgets/SearchBar.dart';
import '../../widgets/WhiteAppBar.dart';
import '../course/model/CourseModel.dart';

class TeacherCoach extends StatefulWidget {
  const TeacherCoach({super.key});

  @override
  State<TeacherCoach> createState() => _TeacherCoachState();
}

class _TeacherCoachState extends State<TeacherCoach> {
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

  List<Course> searchResults = [];

  void onQueryChanged(String query) {
    //servis query isteği at
    setState(() {
      searchResults = courseList.where((item) => item.quota != 0).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Eğitim Koçu"),
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
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: YoSearchBar(onQueryChanged: onQueryChanged)),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            showCompanyFilterBottomSheet(context);
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
                          colors: HexColor(courseList[index].lesson!.color!),
                        ),
                      );
                    },
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
