import 'package:baykurs/ui/dashboard/incoming_course.dart';
import 'package:baykurs/util/LessonExtension.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../util/FirebaseAnalyticsConstants.dart';
import '../../util/FirebaseAnalyticsManager.dart';
import '../../util/HexColor.dart';
import '../../util/YOColors.dart';
import '../../widgets/CourseListItem.dart';
import '../../widgets/QuickAction.dart';
import '../coursedetail/model/course_detail_args.dart';
import '../login/loginPage.dart';
import 'model/mobile_home_response.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;

class ResponsiveHelper {
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width > 600;
}

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
    final isTablet = ResponsiveHelper.isTablet(context);
    return carousel_slider.CarouselSlider(
      carouselController: controller,
      options: carousel_slider.CarouselOptions(
        height: isTablet ? 320.0 : 220.0,
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
                    Text("", style: styleBlack18Bold),
                    Text("", style: styleBlack14Regular),
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

  void _handleQuickActionNavigation(
      BuildContext context, QuickActionPage action) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("auth_token");
    _logQuickActionEvent(action.index);
    if (!context.mounted) return;

    if ((action.index == 0 || action.index == 4) &&
        (token == null || token.isEmpty)) {
      Navigator.of(context, rootNavigator: true).push(
        _createPageRoute(const LoginPage(showClose: true)),
      );
    } else {
      Navigator.of(context, rootNavigator: true).pushNamed(action.routeName);
    }
  }

  void _logQuickActionEvent(int actionIndex) {
    switch (actionIndex) {
      case 0:
        FirebaseAnalyticsManager.logEvent(
            FirebaseAnalyticsConstants.quick_action_timesheet);
        break;
      case 1:
        FirebaseAnalyticsManager.logEvent(
            FirebaseAnalyticsConstants.quick_action_course);
        break;
      case 2:
        FirebaseAnalyticsManager.logEvent(
            FirebaseAnalyticsConstants.quick_action_course_bundle);
        break;
      case 3:
        FirebaseAnalyticsManager.logEvent(
            FirebaseAnalyticsConstants.quick_action_school);
        break;
      case 4:
        FirebaseAnalyticsManager.logEvent(
            FirebaseAnalyticsConstants.quick_action_request_course);
        break;
      case 5:
        FirebaseAnalyticsManager.logEvent(
            FirebaseAnalyticsConstants.quick_action_teach_coach);
        break;
      default:
        FirebaseAnalyticsManager.logEvent("unknown_quick_action",
            parameters: {"action_index": actionIndex});
    }
  }

  PageRouteBuilder _createPageRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: quickActionList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveHelper.isTablet(context) ? 5 : 3,
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
    final isTablet = ResponsiveHelper.isTablet(context);
    final cardWidth = isTablet
        ? MediaQuery.of(context).size.width / 2.5
        : MediaQuery.of(context).size.width * 0.96;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 4.2,
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: lessons.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: cardWidth),
                child: InkWell(
                  onTap: () {
                    final course = lessons[index];
                    FirebaseAnalyticsManager.logEvent(
                      FirebaseAnalyticsConstants.interested_course_click,
                    );
                    Navigator.of(context, rootNavigator: true).pushNamed(
                      '/courseDetail',
                      arguments: CourseDetailArgs(
                        courseId: course.id ?? 0,
                        isIncomingLesson: true,
                      ),
                    );
                  },
                  child: IncomingCourse(
                    courseModel: lessons[index],
                    colors: HexColor("#4A90E2"),
                  ),
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
    final isTablet = ResponsiveHelper.isTablet(context);
    final cardWidth = isTablet
        ? MediaQuery.of(context).size.width / 2.5
        : MediaQuery.of(context).size.width * 0.96;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3.8,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: lessons.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: cardWidth,
              child: InkWell(
                onTap: () {
                  FirebaseAnalyticsManager.logEvent(
                      FirebaseAnalyticsConstants.interested_course_click);
                  Navigator.of(context, rootNavigator: true).pushNamed(
                    '/courseDetail',
                    arguments: CourseDetailArgs(
                      courseId: lessons[index].id ?? 0,
                      isIncomingLesson: false,
                    ),
                  );
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
    final isTablet = ResponsiveHelper.isTablet(context);
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16),
      child: Text(
        title,
        style: isTablet ? styleBlack20Bold : styleBlack16Bold,
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
