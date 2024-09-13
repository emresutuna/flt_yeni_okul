import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:yeni_okul/widgets/GenericDropdown.dart';

import '../../util/YOColors.dart';
import 'RequestLessonModel.dart';

class RequestLessonPage extends StatefulWidget {
  const RequestLessonPage({super.key});

  @override
  State<RequestLessonPage> createState() => _RequestLessonPageState();
}

class _RequestLessonPageState extends State<RequestLessonPage> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final lessonList = [
    "Matematik",
    "Türkçe",
    "Fizik",
    "Biyoloji",
    "Geometri",
    "Tarih",
  ];
  final subjectList = [
    "Köklü sayılar",
    "Denklemler",
  ];
  final List<String> areaList = [];
  final requestLessonModel = RequestLessonModel();
  var pwdWidgets = <Widget>[];
  final StreamController<Widget> _checkBoxController = StreamController();

  Stream<Widget> get _checkBoxStream => _checkBoxController.stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Ders Talep Et',
            style: styleBlack14Bold,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  children: [
                    Text(
                      "Lorem ipsum dolar sit amet lorem ipsum dolar sit amet sit amet",
                      style: styleBlack12Bold,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    dropdownButton(
                      items: lessonList,
                      hintText: "Ders Seç",
                      onChanged: (value) {
                        requestLessonModel.lessonName = value ?? "";
                        pwdWidgets.add(Text("dasdasd"));
                        _checkBoxController.sink.add(Text("data"));
                      },
                      onSaved: (value) {
                        requestLessonModel.lessonName = value ?? "";
                        pwdWidgets.add(Text("dasdasd"));
                        _checkBoxController.sink.add(Text("data"));
                      },
                      onError: (value) {},
                    ),
                    StreamBuilder<Widget>(
                        stream: _checkBoxStream,
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            pwdWidgets.add(snapshot.data!);
                          }
                          return Column(children: pwdWidgets);
                        }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
