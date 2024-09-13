import 'package:flutter/material.dart';

import '../../widgets/CourseListItem.dart';
import '../company/model/CompanyModel.dart';
import '../course/model/CourseModel.dart';
class TimeSheetCourseList extends StatefulWidget {
  const TimeSheetCourseList({super.key});

  @override
  State<TimeSheetCourseList> createState() => _TimeSheetCourseListState();
}

class _TimeSheetCourseListState extends State<TimeSheetCourseList> {
  List<CourseModel> courseList = [
    CourseModel(
        id: 1,
        courseId: 1,
        courseName: "Köklü Sayılar",
        courseTitle: "Köklü Sayılar",
        courseDesc: "Köklü sayılar ders anlatımı",
        courseType: "Matematik",
        date: "23.04.23",
        startDate: "24.04.23",
        endDate: "24.04.23",
        hasPackageCourse: false,
        time: "14:00",
        quota: "5 kişi",
        price: "100₺",
        location: "Esenler/İstanbul",
        teacher: Teacher(
            id: 1,
            teacherName: "Tamer",
            teacherSurname: "Yüksel",
            teacherBranch: "Matematik"),
        company: CompanyModel(
            id: 1,
            companyId: 1,
            companyName: "Esenler Açı Dershanesi",
            companyDesc: "Esenler Açı Dershanesia",
            companyTitle: "title",
            companyPhoto: "assets/company_logo.jpg",
            companyLocation: [43.12312, 31.2131],
            teacherList: null))
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return CourseListItem();
                },
              )),

        ],
      ),
    );
  }
}
