import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
    QuickActionModel(name: "Deneme Kulubü", icon: "assets/ic_trial_club.png"),
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
      case 5: // Deneme Kulubü
        Navigator.of(context, rootNavigator: true)
            .pushNamed("/userEditSelection");
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
    List<Course> courses = lessons.map((lesson) => lesson.toCourse()).toList();

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
                colors: HexColor(courses[index].lesson!.color!),
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

Course mapIncomingLessonToCourse(IncomingLesson incomingLesson) {
  return Course(
    id: incomingLesson.id,
    schoolId: incomingLesson.schoolId,
    lessonId: incomingLesson.lessonId,
    teacherId: incomingLesson.teacherId,
    startDate: incomingLesson.startDate != null
        ? DateTime.tryParse(incomingLesson.startDate!)
        : null,
    endDate: incomingLesson.endDate != null
        ? DateTime.tryParse(incomingLesson.endDate!)
        : null,
    classroom: incomingLesson.classroom,
    deadline: incomingLesson.deadline != null
        ? DateTime.tryParse(incomingLesson.deadline!)
        : null,
    price: incomingLesson.price?.toDouble(),
    quota: incomingLesson.quota,
    createdAt: null,
    updatedAt: null,
    deletedAt: null,
    school: incomingLesson.school,
    lesson: incomingLesson.lesson as Lesson?,
    teacher: incomingLesson.teacher as Teacher?,
  );
}

extension IncomingLessonMapper on IncomingLesson {
  Course toCourse() {
    return Course(
      id: id,
      schoolId: schoolId,
      lessonId: lessonId,
      teacherId: teacherId,
      startDate: startDate != null ? DateTime.tryParse(startDate!) : null,
      endDate: endDate != null ? DateTime.tryParse(endDate!) : null,
      classroom: classroom,
      deadline: deadline != null ? DateTime.tryParse(deadline!) : null,
      price: price?.toDouble(),
      quota: quota,
      createdAt: null,
      updatedAt: null,
      deletedAt: null,
      school: school,
      lesson: lesson as Lesson?,
      teacher: teacher as Teacher?,
    );
  }
}
