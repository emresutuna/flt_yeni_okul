import 'package:baykurs/ui/timesheet/model/TimeSheetMapper.dart';
import 'package:baykurs/util/ListExtension.dart';
import 'package:baykurs/widgets/ErrorWidget.dart';
import 'package:flutter/material.dart';

import '../../util/HexColor.dart';
import '../../widgets/CourseListItem.dart';
import '../course/model/course_model.dart';
import '../coursedetail/model/course_detail_args.dart';
import 'model/TimeSheetResponse.dart';

class TimeSheetCourseList extends StatefulWidget {
  final List<TimeSheet> timeSheetList;

  const TimeSheetCourseList({super.key, required this.timeSheetList});

  @override
  State<TimeSheetCourseList> createState() => _TimeSheetCourseListState();
}

class _TimeSheetCourseListState extends State<TimeSheetCourseList> {
  @override
  Widget build(BuildContext context) {
    List<CourseList> courseList =
        widget.timeSheetList.map((timeSheet) => timeSheet.toCourse()).toList();

    return Scaffold(
      body: Column(
        children: [
          courseList.isNullOrEmpty
              ? const BkErrorWidget(
                  title: "Bu Hafta Boşsun",
                  description: "Şu anda hiçbir ders satın almadığın için ders programın oluşturulamadı")
              : Expanded(
                  child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: widget.timeSheetList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/courseDetail',
                            arguments: CourseDetailArgs(courseId: courseList[index].id??0, isIncomingLesson: false));
                      },
                      child: CourseListItem(
                        courseModel: courseList[index],
                        colors: HexColor("#4A90E2"),
                      ),
                    );
                  },
                ))
        ],
      ),
    );
  }
}
