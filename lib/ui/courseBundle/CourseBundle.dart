import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
class CourseBundle extends StatefulWidget {
  const CourseBundle({super.key});

  @override
  State<CourseBundle> createState() => _CourseBundleState();
}

class _CourseBundleState extends State<CourseBundle> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: WhiteAppBar( "Paket Ders",onTap: (){}),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
