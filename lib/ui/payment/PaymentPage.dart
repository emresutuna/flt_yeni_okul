import 'package:flutter/material.dart';
import 'package:yeni_okul/ui/course/model/CourseModel.dart';
import 'package:yeni_okul/widgets/YOText.dart';

import '../../util/YOColors.dart';
import '../../widgets/YOAppBar.dart';
import '../../widgets/YOButton.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

late CourseModel selectedCourse;

class _PaymentPageState extends State<PaymentPage> {
  @override
  void initState() {
    readArgs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> key = GlobalKey();
    readArgs();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: YOAppBar(
        enableBackButton: true,
        drawerKey: key,
      ),
      body: SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.only(top: 90),
            decoration: gradient,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                YoText(text: selectedCourse.teacher!.teacherName!)
              ],
            ),
          )),
    );
  }

  readArgs() {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, CourseModel>;
    selectedCourse = args["courseModel"]!;
  }
}
