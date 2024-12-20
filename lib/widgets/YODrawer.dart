import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../util/HexColor.dart';
import 'YOText.dart';

class YODrawer extends StatelessWidget {
  final PageController pageController;

  const YODrawer({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/ic_drawer.png"),
                DrawerText(
                  text: 'Dashboard',
                  icon: Icons.dashboard_customize_outlined,
                  onTap: () {
                    Navigator.pop(context);
                    pageController.jumpTo(0);
                  },
                  id: 0,
                  pageController: pageController,
                ),
                DrawerText(
                  text: 'Course',
                  icon: FontAwesomeIcons.book,
                  onTap: () {
                    Navigator.pop(context);
                    pageController.animateToPage(1,
                        duration: const Duration(microseconds: 5000),
                        curve: Curves.easeInBack);
                  },
                  id: 1,
                  pageController: pageController,
                ),
                DrawerText(
                  text: 'Student',
                  icon: FontAwesomeIcons.person,
                  onTap: () {
                    pageController.jumpTo(2);
                  },
                  id: 2,
                  pageController: pageController,
                ),
                DrawerText(
                  text: 'Transactions',
                  icon: FontAwesomeIcons.getPocket,
                  onTap: () {
                    pageController.jumpTo(3);
                  },
                  id: 3,
                  pageController: pageController,
                ),
                DrawerText(
                  text: 'Chat',
                  icon: FontAwesomeIcons.message,
                  onTap: () {
                    pageController.jumpTo(4);
                  },
                  id: 4,
                  pageController: pageController,
                ),
                DrawerText(
                  text: 'Schedule',
                  icon: Icons.schedule,
                  onTap: () {
                    pageController.jumpTo(5);
                  },
                  id: 5,
                  pageController: pageController,
                ),
                DrawerText(
                  text: 'Live Class',
                  icon: FontAwesomeIcons.camera,
                  onTap: () {
                    pageController.jumpTo(6);
                  },
                  id: 6,
                  pageController: pageController,
                ),
                DrawerText(
                  text: 'Settings',
                  icon: Icons.settings,
                  onTap: () {
                    pageController.jumpTo(1);
                  },
                  id: 7,
                  pageController: pageController,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DrawerText extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final int id;
  final PageController pageController;

  const DrawerText(
      {super.key,
      required this.text,
      required this.icon,
      required this.onTap,
      required this.id,
      required this.pageController});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Row(
          children: [
            const Padding(padding: EdgeInsets.only(left: 16)),
            Icon(
              icon,
              color: pageController.page != id
                  ? HexColor("#9295A3")
                  : HexColor("#4DC591"),
              size: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: YoText(
                text: text,
                color: pageController.page != id
                    ? HexColor("#9295A3")
                    : HexColor("#4DC591"),
                size: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//TODO listeden seçilen elemanın rengini değiştir
var menus = [
  {
    'name': 'Dashboard',
    'icon': Icons.dashboard_customize_outlined,
    'route': '/dashboard',
    'active': true,
  },
  {
    'name': 'Course',
    'icon': Icons.book,
    'route': '/course',
    'active': false,
  },
  {
    'name': 'Student',
    'icon': Icons.bookmark,
    'route': '/student',
    'active': false,
  },
  {
    'name': 'Transactions',
    'icon': Icons.play_circle_filled,
    'route': '/transactions',
    'active': false,
  },
  {
    'name': 'Chat',
    'icon': Icons.message,
    'route': '/chat',
    'active': false,
  },
  {
    'name': 'Schedule',
    'icon': Icons.schedule,
    'route': '/schedule',
    'active': false,
  },
  {
    'name': 'Live Class',
    'icon': Icons.live_tv_rounded,
    'route': '/live',
    'active': false,
  },
  {
    'name': 'Settings',
    'icon': Icons.settings,
    'route': '/settings',
    'active': false,
  },
];

enum DrawerSections {
  dashboard,
  course,
  student,
  transactions,
  schedule,
  live,
  settings,
}
