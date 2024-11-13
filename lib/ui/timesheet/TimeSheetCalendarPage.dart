import 'package:baykurs/util/HexColor.dart';
import 'package:baykurs/util/ListExtension.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../util/YOColors.dart';
import '../../widgets/ErrorWidget.dart';
import 'model/TimeSheetResponse.dart';

class TimeSheetCalendarPage extends StatefulWidget {
  final List<TimeSheet> timeSheetList;

  const TimeSheetCalendarPage({super.key, required this.timeSheetList});

  @override
  State<TimeSheetCalendarPage> createState() => _TimeSheetCalendarPageState();
}

class _TimeSheetCalendarPageState extends State<TimeSheetCalendarPage> {
  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];

    for (var data in widget.timeSheetList) {
      DateTime startTime = DateTime.parse(data.startDate!);
      DateTime endTime = DateTime.parse(data.endDate!);
      meetings.add(Meeting(data.lesson!.name!, startTime, endTime,
          HexColor(data.lesson!.color!), false, data.id!));
    }

    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.timeSheetList.isNullOrEmpty
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.start, // Aligns to the top
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Centers horizontally
                children: [
                  BkErrorWidget(
                    title: "Hata",
                    description: "Şuanda hiçbir ders satın almadınız",
                  ),
                ],
              )
            : SfCalendar(
                view: CalendarView.week,
                dataSource: MeetingDataSource(_getDataSource()),
                showCurrentTimeIndicator: true,
                todayHighlightColor: color5,
                weekNumberStyle: WeekNumberStyle(
                  backgroundColor: color5,
                  textStyle: styleWhite16Regular,
                ),
                selectionDecoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  shape: BoxShape.rectangle,
                ),
                onTap: (CalendarTapDetails details) {
                  dynamic appointment = details.appointments;
                  if (appointment != null && appointment.isNotEmpty) {
                    Meeting meeting = appointment[0];
                    Navigator.pushNamed(
                      context,
                      '/courseDetail',
                      arguments: meeting.courseId,
                    );
                  }
                },
              ),
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay,
      this.courseId);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;

  int courseId;
}
