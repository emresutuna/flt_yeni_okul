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
                  return Placeholder();
                 // return CourseListItem();
                },
              )),

        ],
      ),
    );
  }
}
