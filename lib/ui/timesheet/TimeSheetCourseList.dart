import 'package:baykurs/ui/timesheet/model/TimeSheetMapper.dart';
import 'package:baykurs/util/ListExtension.dart';
import 'package:baykurs/widgets/ErrorWidget.dart';
import 'package:flutter/material.dart';

import '../../util/HexColor.dart';
import '../../widgets/CourseListItem.dart';
import '../course/model/CourseModel.dart';
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
    List<Course> courseList =
        widget.timeSheetList.map((timeSheet) => timeSheet.toCourse()).toList();

    return Scaffold(
      body: Column(
        children: [
          courseList.isNullOrEmpty
              ? const BkErrorWidget(
                  title: "Hata",
                  description: "Şuanda hiçbir ders satın almadınız")
              : Expanded(
                  child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: widget.timeSheetList.length,
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
                ))
        ],
      ),
    );
  }
}
