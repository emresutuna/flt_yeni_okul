import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/YOColors.dart';
import '../../widgets/InfoWidget.dart';
import '../../widgets/WhiteAppBar.dart';
import '../course/bloc/LessonBloc.dart';
import '../course/bloc/LessonEvent.dart';
import '../course/bloc/LessonState.dart';
import 'model/CourseCoachDetailResponse.dart';

class TeacherCoachDetail extends StatefulWidget {
  const TeacherCoachDetail({super.key});

  @override
  State<TeacherCoachDetail> createState() => _TeacherCoachDetailState();
}

class _TeacherCoachDetailState extends State<TeacherCoachDetail> {
  late CourseCoachDetail? courseDetail;
  late int courseId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context) != null) {
        courseId = ModalRoute.of(context)!.settings.arguments as int;
        context.read<LessonBloc>().add(FetchCourseCoachDetail(id: courseId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Eğitim Koçu Detay"),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 24),
                  child: Text(
                    "Bu hafta yayınlanan dersleri incele ve haftalık programını oluştur.",
                    style: styleBlack12Bold,
                    textAlign: TextAlign.start,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16, top: 16),
                  child: InfoCardWidget(
                      title: "Dersler",
                      description:
                          "Dersin verildiği kurum ve ders hakkında detayları inceleyebilir, dersi satın alabilirsin. Dilersen, üst menüden seçim yaparak sadece favori kurumlarının yayınladığı dersleri görüntüleyebilirsin. Almak istediğin ders yayında yoksa Ders Talep Et özelliğini kullanabilirsin."),
                ),
                Expanded(
                  child: BlocBuilder<LessonBloc, LessonState>(
                    builder: (context, state) {
                      if (state is CourseCoachDetailSuccess) {
                        courseDetail = state.courseCoachResponse.data;
                        return Column(
                          children: [
                            Text(courseDetail?.title ?? 'Data gelmiyor')
                          ],
                        );
                      } else if (state is LessonStateError) {
                        return Center(child: Text('Error: ${state.error}'));
                      } else {
                        return Center(child: Text('No courses available'));
                      }
                    },
                  ),
                ),
              ],
            ),
            BlocBuilder<LessonBloc, LessonState>(
              builder: (context, state) {
                if (state is LessonStateLoading) {
                  return Container(
                    color: Colors.black54, // Semi-transparent background
                    child: const Center(
                      child: CircularProgressIndicator(), // Loading spinner
                    ),
                  );
                }
                return SizedBox.shrink(); // Invisible widget when not loading
              },
            ),
          ],
        ),
      ),
    );
  }
}
