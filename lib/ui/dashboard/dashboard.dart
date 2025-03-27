import 'package:baykurs/ui/dashboard/dashboard_extension.dart';
import 'package:baykurs/ui/dashboard/bloc/dashboard_bloc.dart';
import 'package:baykurs/ui/dashboard/bloc/dashboard_event.dart';
import 'package:baykurs/ui/dashboard/bloc/dashboard_state.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../util/GlobalLoading.dart';
import '../../util/SharedPrefHelper.dart';
import 'model/mobile_home_response.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late carousel_slider.CarouselSliderController controller;

  List<SliderData> sliderData = [];
  List<IncomingLesson> incomingLessons = [];
  List<InterestedLesson> interestedLessons = [];

  @override
  void initState() {
    super.initState();
    controller = carousel_slider.CarouselSliderController();
    context.read<DashboardBloc>().add(FetchDashboard());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const GlobalFadeAnimation();
            }
            if (state is DashboardSuccess) {
              sliderData = state.mobileHomeResponse.sliderData ?? [];
              incomingLessons = state.mobileHomeResponse.incomingLesson ?? [];
              interestedLessons =
                  state.mobileHomeResponse.interestedLesson ?? [];
              saveNotification(state.mobileHomeResponse.notifications!);
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sliderData.isNotEmpty
                      ? HomeCarouselWidget(
                          sliderData: sliderData, controller: controller)
                      : const SizedBox(),
                  _buildInfoCardIfNeeded(),
                  const SectionTitle(title: "Kolay İşlemler"),
                  const QuickActionGrid(),
                  incomingLessons.isNotEmpty
                      ? const SectionTitle(title: "Yaklaşan Dersler")
                      : const SizedBox(),
                  incomingLessons.isNotEmpty
                      ? IncomingLessonsWidget(lessons: incomingLessons)
                      : const SizedBox(),
                  interestedLessons.isNotEmpty
                      ? const SectionTitle(title: "İlgilenebileceğin Dersler")
                      : const SizedBox(),
                  interestedLessons.isNotEmpty
                      ? InterestedLessonsWidget(lessons: interestedLessons)
                      : const SizedBox(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoCardIfNeeded() {
    if (incomingLessons.isEmpty) return const SizedBox();

    final nextLesson = incomingLessons.first;
    final now = DateTime.now();
    final startTime = DateTime.parse(nextLesson.startDate!);
    final duration = startTime.difference(now);

    final bool isWithinOneHourWindow = duration.inMinutes.abs() <= 60;

    if (isWithinOneHourWindow && !nextLesson.isAttendanceCompleted!) {
      String routeName = '/courseDetail';
      dynamic argument = nextLesson.id;

      if (nextLesson.courseBundleId != null && nextLesson.courseBundleId != 0) {
        routeName = '/courseBundleDetail';
        argument = nextLesson.courseBundleId;
      } else if (nextLesson.courseCoachId != null &&
          nextLesson.courseCoachId != 0) {
        routeName = '/coachDetail';
        argument = nextLesson.courseCoachId;
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pushNamed(
              routeName,
              arguments: argument,
            );
          },
          child: Card(
            elevation: 3,
            color: Colors.yellow.shade100,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.orange),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "📚 ${nextLesson.lesson?.name ?? 'Ders'} ${nextLesson.courseType == 0 ? 'dersin' : 'kursun'} başlamak üzere! Yoklama almayı unutma.",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return const SizedBox();
  }
}
