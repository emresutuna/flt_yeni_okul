import 'package:baykurs/ui/dashboard/incomingCourse.dart';
import 'package:baykurs/util/LessonExtension.dart';
import 'package:flutter/material.dart';
import '../../util/HexColor.dart';
import '../../util/YOColors.dart';
import '../../widgets/CourseListItem.dart';
import '../../widgets/QuickAction.dart';
import 'model/MobileHomeResponse.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;

class HomeCarouselWidget extends StatelessWidget {
  final List<SliderData> sliderData;
  final carousel_slider.CarouselSliderController controller;

  const HomeCarouselWidget({
    super.key,
    required this.sliderData,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return carousel_slider.CarouselSlider(
      carouselController: controller,
      options: carousel_slider.CarouselOptions(
        height: 220.0,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: sliderData.map((data) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                    data.img ?? 'https://via.placeholder.com/300',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "",
                      style: styleBlack18Bold,
                    ),
                    Text(
                      "",
                      style: styleBlack14Regular,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class QuickActionGrid extends StatelessWidget {
  final List<QuickActionPage> quickActionList = QuickActionPage.values;

  const QuickActionGrid({super.key});

  void _handleQuickActionNavigation(BuildContext context, QuickActionPage action) {
    Navigator.of(context, rootNavigator: true).pushNamed(action.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: quickActionList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.98,
      ),
      itemBuilder: (context, index) {
        final action = quickActionList[index];
        return InkWell(
          onTap: () => _handleQuickActionNavigation(context, action),
          child: QuickAction(
            icon: action.icon,
            name: action.displayName,
          ),
        );
      },
    );
  }
}

class IncomingLessonsWidget extends StatelessWidget {
  final List<IncomingLesson> lessons;

  const IncomingLessonsWidget({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height /3.5, // Maksimum yükseklik
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: lessons.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.96,
                ),
                child: IncomingCourse(
                  courseModel: lessons[index],
                  colors: HexColor("#4A90E2"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
class InterestedLessonsWidget extends StatelessWidget {
  final List<InterestedLesson> lessons;

  const InterestedLessonsWidget({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 4.4,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: lessons.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.96,
              child: InkWell(
                onTap: (){
                  Navigator.of(context,
                      rootNavigator:true
                  )
                      .pushNamed('/courseDetail',
                      arguments: lessons[index].id);
                },
                child: InterestedLessonWidget(
                  courseModel: lessons[index],
                  colors: HexColor(DEFAULT_LESSON_COLOR),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16),
      child: Text(
        title,
        style: styleBlack16Bold,
      ),
    );
  }
}

enum QuickActionPage {
  timeSheet,
  courseList,
  courseBundleList,
  companyList,
  requestLesson,
  teacherCoach,
}

extension QuickActionPageExtension on QuickActionPage {
  String get routeName {
    switch (this) {
      case QuickActionPage.timeSheet:
        return "/timeSheetPage";
      case QuickActionPage.courseList:
        return "/courseListPage";
      case QuickActionPage.courseBundleList:
        return "/courseBundleList";
      case QuickActionPage.companyList:
        return "/companyList";
      case QuickActionPage.requestLesson:
        return "/requestLessonPage";
      case QuickActionPage.teacherCoach:
        return "/teacherCoach";
    }
  }

  String get displayName {
    switch (this) {
      case QuickActionPage.timeSheet:
        return "Ders Programı";
      case QuickActionPage.courseList:
        return "Ders Bul";
      case QuickActionPage.courseBundleList:
        return "Kurs Bul";
      case QuickActionPage.companyList:
        return "Kurum Bul";
      case QuickActionPage.requestLesson:
        return "Ders/Kurs Talep Et";
      case QuickActionPage.teacherCoach:
        return "Eğitim Koçu";
    }
  }

  String get icon {
    switch (this) {
      case QuickActionPage.timeSheet:
        return "assets/ic_time_sheet.png";
      case QuickActionPage.courseList:
        return "assets/ic_find_course.png";
      case QuickActionPage.courseBundleList:
        return "assets/ic_trial_club.png";
      case QuickActionPage.companyList:
        return "assets/ic_find_school.png";
      case QuickActionPage.requestLesson:
        return "assets/ic_request_course.png";
      case QuickActionPage.teacherCoach:
        return "assets/ic_training_coach.png";
    }
  }

}