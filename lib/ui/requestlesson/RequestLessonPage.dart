import 'dart:convert';
import 'package:baykurs/service/apiUrls.dart';
import 'package:baykurs/ui/requestlesson/CourseRequest.dart';
import 'package:baykurs/ui/requestlesson/bloc/RequestLessonBloc.dart';
import 'package:baykurs/ui/requestlesson/bloc/RequestLessonState.dart';
import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/SharedPrefHelper.dart';
import 'package:baykurs/widgets/BranchesDropDown.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../util/LessonExtension.dart';
import '../../util/YOColors.dart';
import '../../widgets/infoWidget/InfoWidget.dart';
import '../../widgets/PrimaryButton.dart';
import 'CourseRequestSchool.dart';
import 'Region.dart';
import 'bloc/RequestLessonEvent.dart';

class RequestLessonPage extends StatefulWidget {
  const RequestLessonPage({Key? key}) : super(key: key);

  @override
  _RequestLessonPageState createState() => _RequestLessonPageState();
}

class _RequestLessonPageState extends State<RequestLessonPage> {
  final TextEditingController lessonController = TextEditingController();

  Branches? selectedBranch;
  BranchTopic? selectedTopic;
  List<BranchTopic> branchTopics = [];
  Region? selectedRegion;
  List<Region> regions = [];
  Province? selectedProvince;
  CourseRequestSchool? selectedSchool;
  List<Province> provinces = [];
  List<CourseRequestSchool> schools = [];
  String? selectedTimeRange;

  void handleBranchSelection(Branches? branch) {
    setState(() {
      selectedBranch = branch;
      if (selectedBranch != null) {
        var branchFiltered =
            filterBranchTopicsByBranch(classLevelBranches, selectedBranch!);
        branchTopics = branchFiltered;
        selectedTopic = null;
      } else {
        branchTopics = [];
        selectedTopic = null;
      }
    });
  }

  Future<void> fetchRegions() async {
    final response = await http.get(Uri.parse(ApiUrls.getProvinceAllURL));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true) {
        final List<dynamic> regionsData = responseData['data'];
        final List<Region> regionList = regionsData.map((regionJson) {
          return Region.fromJson(regionJson);
        }).toList();

        setState(() {
          regions = regionList;
        });
      }
    } else {
      throw Exception('Failed to load regions');
    }
  }

  Future<void> fetchProvince(int provinceId) async {
    final response = await http
        .get(Uri.parse(ApiUrls.getAllDistrictsAllURL(selectedRegion?.id ?? 0)));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true) {
        final List<dynamic> districtsData = responseData['data'];
        final List<Province> districtList = districtsData.map((districtJson) {
          return Province.fromJson(districtJson);
        }).toList();

        setState(() {
          provinces = districtList;
        });
      }
    } else {
      throw Exception('Failed to load districts');
    }
  }

  Future<void> fetchSchool() async {
    try {
      final String? token = await getToken();

      final url = selectedRegion == null
          ? ApiUrls.getCourseRequestSchools
          : ApiUrls.getCourseRequestSchoolsById(
              selectedRegion?.id ?? 0, selectedProvince?.id ?? 0);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'X-Requested-From': 'baykursmobileapp'
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == true) {
          final List<dynamic> data = responseData['data'];

          final List<CourseRequestSchool> schoolList =
              data.map((json) => CourseRequestSchool.fromJson(json)).toList();

          setState(() {
            schools = schoolList;
          });
        } else {
          throw Exception(
              'Unexpected response status: ${responseData['status']}');
        }
      } else {
        throw Exception(
            'Failed to load schools, status code: ${response.statusCode}');
      }
    } catch (error) {
      Get.snackbar(
        "Hata",
        "Kurumlar şuanlık alınamıyor",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
      debugPrint('Error fetching schools: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRegions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Ders Talep Et"),
      body: BlocConsumer<RequestLessonBloc, RequestLessonState>(
        listener: (BuildContext context, RequestLessonState state) {
          if (state is RequestLessonSuccess) {
            Get.snackbar(
              "Başarılı",
              "Ders Talebi Gönderildi",
              colorText: Colors.white,
              backgroundColor: Colors.green,
            );
            Navigator.pushReplacementNamed(context, '/mainPage');
          } else if (state is RequestLessonError) {
            Get.snackbar(
              "Hata",
              "Ders Talebi Gönderilemedi",
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
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
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'İhtiyacın olan dersi talep et.',
                              style: styleBlack12Bold,
                            ),
                            const SizedBox(height: 16),
                            const InfoCardWidget(
                              title: 'Bilgi',
                              description:
                                  'Bir bölgedeki tüm kurumlardan ya da tek bir kurumdan ders talebinde bulunarak, kurumların talep ettiğin dersi yayınlamalarını sağlayabilirsin.',
                              icon: Icons.info_outline,
                            ),
                            const SizedBox(height: 16),
                            BranchesDropdown(
                                onBranchSelected: handleBranchSelection),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<BranchTopic>(
                                    isExpanded:true,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: color1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: color1),
                                      ),
                                    ),
                                    items:
                                        branchTopics.map((BranchTopic topic) {
                                      return DropdownMenuItem<BranchTopic>(
                                        value: topic,
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                          ),
                                          child: Text(
                                            topic.name,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            maxLines: 1,
                                            style: styleBlack14Bold,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: selectedBranch == null
                                        ? null
                                        : (BranchTopic? newValue) {
                                            setState(() {
                                              selectedTopic = newValue;
                                            });
                                          },
                                    hint: Text(
                                      'Konu Seç',
                                      style: styleBlack14W600.copyWith(color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      maxLines: 1,
                                    ),
                                    value: selectedTopic,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: DropdownButtonFormField<Region>(
                                isExpanded:true,

                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: color1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: color1),
                                  ),
                                ),
                                items: regions.toDropdownItems(),
                                onChanged: (Region? newValue) {
                                  setState(() {
                                    selectedRegion = newValue;
                                    selectedProvince = null;
                                    selectedSchool = null;
                                    schools.clear();
                                    provinces.clear();
                                  });

                                  if (newValue != null) {
                                    fetchProvince(newValue.id);
                                    fetchSchool();
                                  }
                                },
                                hint: Text(
                                  'İl Seç',
                                  style: styleBlack14W600.copyWith(color: Colors.grey),
                                ),
                                value: selectedRegion,
                              ),
                            ),
                            if (provinces.isNotEmpty)
                              Column(
                                children: [
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    child: DropdownButtonFormField<Province>(
                                      isExpanded:true,

                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: 8.borderRadius,
                                          borderSide: BorderSide(color: color1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: 8.borderRadius,
                                          borderSide: BorderSide(color: color1),
                                        ),
                                      ),
                                      items: provinces.toDropdownItems(),
                                      onChanged: (Province? newDistrict) {
                                        setState(() {
                                          selectedProvince = newDistrict;
                                          selectedSchool = null;
                                          schools.clear();
                                        });

                                        if (newDistrict != null) {
                                          fetchSchool();
                                        }
                                      },
                                      hint: Text(
                                        'İlçe Seç',
                                        style: styleBlack14W600.copyWith(color: Colors.grey),
                                      ),
                                      value: selectedProvince,
                                    ),
                                  ),

                                ],
                              ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child:
                                  DropdownButtonFormField<CourseRequestSchool>(
                                    isExpanded:true,
                                    decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: color1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: color1),
                                  ),
                                ),
                                items: (selectedRegion != null &&
                                        selectedProvince != null)
                                    ? schools.toDropdownItems()
                                    : [],
                                onChanged: (CourseRequestSchool? newSchool) {
                                  setState(() {
                                    selectedSchool = newSchool;
                                  });
                                },
                                hint: Text(
                                  'Kurum Seç',
                                  style: styleBlack14W600.copyWith(color: Colors.grey),
                                ),
                                value: selectedSchool,
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: PrimaryButton(
                                text: "Ders Talep Et",
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
                                            schoolId:
                                                selectedSchool!.id.toInt(),
                                            subject: selectedTopic!.name,
                                          ),
                                        ));
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                if (state is RequestLessonLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        },
      ),
    );
  }
}
