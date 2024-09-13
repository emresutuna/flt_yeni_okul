import 'package:flutter/material.dart';
import 'package:yeni_okul/ui/timesheet/TimeSheetCourseList.dart';

import '../../util/YOColors.dart';
import '../../widgets/TabItem.dart';
import 'TimeSheetCalendarPage.dart';

class TimeSheetPage extends StatefulWidget {
  const TimeSheetPage({super.key});

  @override
  State<TimeSheetPage> createState() => _TimeSheetPageState();
}

class _TimeSheetPageState extends State<TimeSheetPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Ders Programı',
            style: styleBlack14Bold,
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: color5.withAlpha(50),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: color5,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: color2,
                  tabs: const [
                    TabItem(title: 'Takvim'),
                    TabItem(title: 'Liste'),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            TimeSheetCalendarPage(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TimeSheetCourseList(),
            ),
          ],
        ),
      ),
    );
  }
}
