import 'package:baykurs/ui/requestlesson/SelectBranchPage.dart';
import 'package:baykurs/ui/requestlesson/SelectProvincePage.dart';
import 'package:baykurs/ui/requestlesson/SelectRegionPage.dart';
import 'package:baykurs/ui/requestlesson/SelectSchoolPage.dart';
import 'package:baykurs/util/GlobalLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../ui/requestlesson/bloc/RequestLessonBloc.dart';
import '../../ui/requestlesson/bloc/RequestLessonState.dart';
import '../../util/LessonExtension.dart';
import '../../util/YOColors.dart';
import '../../widgets/PrimaryButton.dart';
import '../../widgets/WhiteAppBar.dart';
import '../../widgets/infoWidget/InfoWidget.dart';
import 'SelectClassPage.dart';
import 'SelectCourseTypePage.dart';
import 'SelectTopicPage.dart';
import 'bloc/RequestLessonEvent.dart';
import 'model/CourseRequest.dart';
import 'model/CourseRequestSchool.dart';
import 'Region.dart';
import 'model/RequestLessonService.dart';

class RequestLessonPage extends StatefulWidget {
  const RequestLessonPage({Key? key}) : super(key: key);

  @override
  _RequestLessonPageState createState() => _RequestLessonPageState();
}

class _RequestLessonPageState extends State<RequestLessonPage> {
  final RequestLessonService _service = RequestLessonService();

  String? selectedCourseType;
  ClassTypes? selectedClassLevel;

  Branches? selectedBranch;
  BranchTopic? selectedTopic;
  Region? selectedRegion;
  Province? selectedProvince;
  CourseRequestSchool? selectedSchool;

  final ValueNotifier<List<BranchTopic>> branchTopics = ValueNotifier([]);
  final ValueNotifier<List<Region>> regions = ValueNotifier([]);
  final ValueNotifier<List<Province>> provinces = ValueNotifier([]);
  final ValueNotifier<List<CourseRequestSchool>> schools = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    _fetchRegions();
  }

  Future<void> _fetchRegions() async {
    regions.value = await _service.fetchRegions();
  }

  Future<void> _fetchProvinces(int regionId) async {
    final provinceList = await _service.fetchProvinces(regionId);

    if (provinceList.isNotEmpty) {
      provinces.value = provinceList;
    }
  }

  Future<void> _fetchSchools() async {
    schools.value = await _service.fetchSchools(
      selectedRegion?.id ?? 0,
      selectedProvince?.id ?? 0,
    );
  }

  void _onBranchSelected(Branches branch) {
    setState(() {
      selectedBranch = branch;
      branchTopics.value =
          _service.getBranchTopicsByClass(branch, selectedClassLevel!);
      selectedTopic = null;
    });
  }

  Future<void> _onRegionAndProvinceSelected() async {
    final selectedRegion =
        await Get.to(() => SelectRegionPage(regions: regions.value));

    if (selectedRegion != null) {
      setState(() {
        this.selectedRegion = selectedRegion;
        this.selectedProvince = null;
        provinces.value = [];
      });

      await _fetchProvinces(selectedRegion.id);

      final selectedProvince =
          await Get.to(() => SelectProvincePage(provinces: provinces.value));

      if (selectedProvince != null) {
        setState(() {
          this.selectedProvince = selectedProvince;
          selectedSchool = null;
          schools.value = [];
        });

        _fetchSchools();
      }
    }
  }

  void _onSchoolSelected(CourseRequestSchool school) {
    setState(() {
      selectedSchool = school;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Ders/Kurs Talep Et"),
      body: BlocConsumer<RequestLessonBloc, RequestLessonState>(
        listener: (context, state) {
          if (state is RequestLessonSuccess) {
            Get.snackbar("Başarılı", "Ders Talebi Gönderildi",
                colorText: Colors.white, backgroundColor: Colors.green);
            Navigator.pushReplacementNamed(context, '/mainPage');
          } else if (state is RequestLessonError) {
            Get.snackbar("Hata", "Ders Talebi Gönderilemedi",
                colorText: Colors.white, backgroundColor: Colors.red);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('İhtiyacın olan dersi talep et.',
                            style: styleBlack12Bold),
                        const SizedBox(height: 16),
                        const InfoCardWidget(
                          title: 'Bilgi',
                          description:
                              'Bir bölgedeki tüm kurumlardan ya da tek bir kurumdan ders talebinde bulunabilirsin.',
                          icon: Icons.info_outline,
                        ),
                        const SizedBox(height: 16),

                        /// **Ders/Kurs Seçim**
                        _buildSelectionTile(
                          title: "Ders/Kurs Seç",
                          value: selectedCourseType ?? "Seç",
                          onTap: () async {
                            final courseType =
                                await Get.to(() => SelectCourseTypePage());
                            if (courseType != null) {
                              setState(() {
                                selectedCourseType = courseType;
                                selectedClassLevel = null;
                              });
                            }
                          },
                        ),

                        /// **Sınıf Seçim**
                        _buildSelectionTile(
                          title: "Sınıf Seç",
                          value: selectedClassLevel?.value ?? "Seç",
                          onTap: selectedCourseType == null
                              ? () {}
                              : () async {
                                  final classLevel =
                                      await Get.to(() => SelectClassPage());
                                  if (classLevel != null) {
                                    setState(() {
                                      selectedClassLevel = classLevel;
                                      selectedBranch = null;
                                      selectedTopic = null;
                                      branchTopics.value = [];
                                    });
                                  }
                                },
                        ),

                        _buildSelectionTile(
                          title: "Branş Seç",
                          value: selectedBranch?.value ?? "Seç",
                          onTap: selectedClassLevel == null
                              ? () {}
                              : () async {
                            final availableBranches =
                            getBranchesForClassType(selectedClassLevel!);
                            final branch = await Get.to(
                                    () => SelectBranchPage(branches: availableBranches));
                            if (branch != null) {
                              setState(() {
                                selectedBranch = branch;
                                _onBranchSelected(branch);
                              });
                            }
                          },
                        ),

                        ValueListenableBuilder<List<BranchTopic>>(
                          valueListenable: branchTopics,
                          builder: (context, topics, _) {
                            return _buildSelectionTile(
                              title: "Konu Seç",
                              value: selectedTopic?.name ?? "Seç",
                              onTap: topics.isNotEmpty
                                  ? () async {
                                      final topic = await Get.to(() =>
                                          SelectTopicPage(topics: topics));
                                      if (topic != null)
                                        setState(() => selectedTopic = topic);
                                    }
                                  : () {},
                            );
                          },
                        ),

                        _buildSelectionTile(
                          title: "İl/İlçe Seç",
                          value: selectedRegion != null &&
                                  selectedProvince != null
                              ? "${selectedRegion!.name} / ${selectedProvince!.name}"
                              : "Seç",
                          onTap: _onRegionAndProvinceSelected,
                        ),

                        _buildSelectionTile(
                          title: "Kurum Seç",
                          value: selectedSchool?.userName ?? "Seç",
                          onTap: selectedProvince == null
                              ? () {}
                              : () async {
                                  final school = await Get.to(() =>
                                      SelectSchoolPage(schools: schools.value));
                                  if (school != null) _onSchoolSelected(school);
                                },
                        ),

                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            text: "Ders/Kurs Talep Et",
                            onPress: () {
                              if (selectedBranch != null &&
                                  selectedTopic != null &&
                                  selectedSchool != null) {
                                context
                                    .read<RequestLessonBloc>()
                                    .add(RequestLesson(
                                      request: CourseRequest(
                                        topicId: selectedTopic!.id,
                                        cityId: selectedProvince!.id,
                                        schoolId: selectedSchool!.id.toInt(),
                                        subject: selectedTopic!.name,
                                      ),
                                    ));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state is RequestLessonLoading)
                  const Center(child: GlobalFadeAnimation()),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _buildSelectionTile({
  required String title,
  required String value,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300, width: 0.6),
      ),
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(vertical: -1),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        title: Text(title, style: styleBlack14Bold),
        subtitle: Text(value,
            style: styleBlack12Regular.copyWith(color: Colors.grey)),
        trailing: Icon(Icons.arrow_forward_ios, color: color5, size: 16),
        onTap: onTap,
      ),
    ),
  );
}
