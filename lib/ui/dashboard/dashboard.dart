import 'package:baykurs/ui/dashboard/DashboardExtension.dart';
import 'package:baykurs/ui/dashboard/bloc/DashboardBloc.dart';
import 'package:baykurs/ui/dashboard/bloc/DashboardEvent.dart';
import 'package:baykurs/ui/dashboard/bloc/DashboardState.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'model/MobileHomeResponse.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late carousel_slider.CarouselSliderController controller;

  List<SliderData> sliderData = [];
  List<IncomingLesson> incomingLessons = [];
  List<dynamic> interestedLessons = [];

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
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DashboardSuccess) {
              sliderData = state.mobileHomeResponse.sliderData ?? [];
              incomingLessons = state.mobileHomeResponse.incomingLesson ?? [];
              interestedLessons =
                  state.mobileHomeResponse.interestedLesson ?? [];
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
