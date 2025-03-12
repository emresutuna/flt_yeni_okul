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
}
