import 'package:baykurs/ui/timesheet/bloc/TimeSheetBloc.dart';
import 'package:baykurs/ui/timesheet/bloc/TimeSheetEvent.dart';
import 'package:baykurs/ui/timesheet/bloc/TimeSheetState.dart';
import 'package:baykurs/ui/timesheet/model/TimeSheetResponse.dart';
import 'package:baykurs/widgets/ErrorWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../util/YOColors.dart';
import '../../widgets/TabItem.dart';
import 'TimeSheetCalendarPage.dart';
import 'TimeSheetCourseList.dart';

class TimeSheetPage extends StatefulWidget {
  const TimeSheetPage({super.key});

  @override
  State<TimeSheetPage> createState() => _TimeSheetPageState();
}

class _TimeSheetPageState extends State<TimeSheetPage> {
  List<TimeSheet> timeSheet = [];

  @override
  void initState() {
    super.initState();
    context.read<TimeSheetBloc>().add(FetchTimeSheet());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child:
          BlocBuilder<TimeSheetBloc, TimeSheetState>(builder: (context, state) {
        if (state is TimeSheetLoadingState) {
          return const Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          );
        }
        if (state is TimeSheetError) {
          return const BkErrorWidget();
        }
        if (state is TimeSheetSuccess) {
          timeSheet = state.timeSheetResponse.data!;
          return Scaffold(
            backgroundColor: Colors.white,
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
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
            body: TabBarView(
              children: [
                TimeSheetCalendarPage(timeSheetList: timeSheet),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TimeSheetCourseList(
                    timeSheetList: timeSheet,
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
