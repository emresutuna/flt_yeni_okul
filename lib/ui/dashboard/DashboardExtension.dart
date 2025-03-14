import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../util/BaseCourseModel.dart';
import '../../util/HexColor.dart';
import '../../util/YOColors.dart';
import '../../widgets/CourseListItem.dart';
import '../../widgets/QuickAction.dart';
import '../course/model/CourseModel.dart';
import '../model/QuickActionModel.dart';
import 'model/MobileHomeResponse.dart';

class HomeCarouselWidget extends StatelessWidget {
  final List<String> sliderData;
  final CarouselController controller;

  const HomeCarouselWidget({
    super.key,
    required this.sliderData,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: controller,
      options: CarouselOptions(
        height: 200.0,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        autoPlay: false,
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
              ),
              child: Center(
                child: Text(
                  data,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class QuickActionsGrid extends StatelessWidget {
  QuickActionsGrid({super.key});

  final List<QuickActionModel> quickActionList = [
    QuickActionModel(name: "Ders Programı", icon: "assets/ic_time_sheet.png"),
    QuickActionModel(name: "Ders Bul", icon: "assets/ic_find_course.png"),
    QuickActionModel(name: "Kurum Bul", icon: "assets/ic_find_school.png"),
    QuickActionModel(
        name: "Ders Talep Et", icon: "assets/ic_request_course.png"),
    QuickActionModel(name: "Eğitim Koçu", icon: "assets/ic_training_coach.png"),
    QuickActionModel(name: "Kurs(Paket Ders)", icon: "assets/ic_trial_club.png"),
  ];

  void _handleQuickActionNavigation(BuildContext context, int index) {
    switch (index) {
      case 0: // Ders Programı
        Navigator.of(context, rootNavigator: true).pushNamed("/timeSheetPage");
        break;
      case 1: // Ders Bul
        Navigator.of(context, rootNavigator: true).pushNamed("/courseListPage");
        break;
      case 2: // Kurum Bul
        Navigator.of(context, rootNavigator: true).pushNamed("/companyList");
        break;
      case 3: // Ders Talep Et
        Navigator.of(context, rootNavigator: true)
            .pushNamed("/requestLessonPage");
        break;
      case 4: // Eğitim Koçu
        Navigator.of(context, rootNavigator: true).pushNamed("/teacherCoach");
        break;
      case 5: // Paket Ders
        Navigator.of(context, rootNavigator: true).pushNamed("/courseBundleList");

        break;
      default:
        break;
    }
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
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          _handleQuickActionNavigation(context, index);
        },
        child: QuickAction(
          icon: quickActionList[index].icon,
          name: quickActionList[index].name,
        ),
      ),
    );
  }
}

class IncomingLessonsWidget extends StatelessWidget {
  final List<IncomingLesson> lessons;

  const IncomingLessonsWidget({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    List<CourseList> courses = lessons.map((lesson) => CourseMapper.toCourseList(lesson)).toList();

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
              child: CourseListItem(
                courseModel: courses[index],
                colors: HexColor("#4A90E2"),
              ),
            );
          },
        ),
      ),
    );
  }
}

class InterestedLessonsWidget extends StatelessWidget {
  final List<dynamic> lessons;

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
              child: CourseListItem(
                courseModel: lessons[index],
                colors: HexColor(lessons[index].lesson!.color!),
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

class CourseMapper {
  /// CourseList -> IncomingLesson
  static IncomingLesson toIncomingLesson(CourseList courseList) {
    return IncomingLesson(
      id: courseList.id,
      title: courseList.title,
      description: courseList.description,
      startDate: courseList.startDate,
      endDate: courseList.endDate,
      price: courseList.price,
      quota: courseList.quota,
      topics: courseList.topics,
      school: courseList.school != null ? School(name: courseList.schoolName??"", id: 0,) : null, // String'i School nesnesine çevirir
      lesson: courseList.lesson != null ? Lesson(name: courseList.lesson?.name?? courseList.lessonName??"", id: 0, color: "") : null, // String'i User nesnesine çevirir
    );
  }
  /// IncomingLesson -> CourseList
  static CourseList toCourseList(IncomingLesson incomingLesson) {
    return CourseList(
      id: incomingLesson.id,
      title: incomingLesson.title,
      description: incomingLesson.description,
      startDate: incomingLesson.startDate,
      endDate: incomingLesson.endDate,
      price: incomingLesson.price,
      quota: incomingLesson.quota,
      topics: incomingLesson.topics,
      schoolName: incomingLesson.school?.name,
      lessonName: incomingLesson.lesson?.name,
    );
  }
}

