import 'dart:convert';
import 'package:baykurs/service/apiUrls.dart';
import 'package:baykurs/ui/requestlesson/CourseRequest.dart';
import 'package:baykurs/ui/requestlesson/bloc/RequestLessonBloc.dart';
import 'package:baykurs/ui/requestlesson/bloc/RequestLessonState.dart';
import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/widgets/BranchesDropDown.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../util/LessonExtension.dart';
import '../../util/YOColors.dart';
import '../../widgets/InfoWidget.dart';
import '../../widgets/PrimaryButton.dart';
import 'Region.dart';
import 'bloc/RequestLessonEvent.dart';

class RequestLessonPage extends StatefulWidget {
  const RequestLessonPage({Key? key}) : super(key: key);

  @override
  _RequestLessonPageState createState() => _RequestLessonPageState();
}

class _RequestLessonPageState extends State<RequestLessonPage> {
  final TextEditingController lessonController = TextEditingController();

  Branch? selectedBranch;
  BranchTopic? selectedTopic;
  List<BranchTopic> branchTopics = [];
  Region? selectedRegion;
  List<Region> regions = [];
  Province? selectedProvince;
  List<Province> provinces = [];
  String? selectedTimeRange;

  void handleBranchSelection(Branch? branch) {
    setState(() {
      selectedBranch = branch;
      if (selectedBranch != null) {
        branchTopics = selectedBranch!.topics;
        selectedTopic = null;
      } else {
        branchTopics = [];
        selectedTopic = null;
      }
    });
    print('Seçilen Ders ID: ${branch?.id}, Adı: ${branch?.name}');
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
            state.error,
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      }, builder: (context, state) {
        return SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'İhtiyacın olan dersi talep ederek sonraki haftanın programına dahil edebilirsin.',
                        style: styleBlack12Bold,
                      ),
                      const SizedBox(height: 16),
                      const InfoCardWidget(
                        title: 'Bilgi',
                        description:
                            'Bir bölgedeki tüm kurumlardan ya da tek bir kurumdan ders talebinde bulunarak, kurumların bir sonraki haftanın ders programına talep ettiğin dersi eklemelerini sağlayabilirsin.',
                        icon: Icons.info_outline,
                      ),
                      const SizedBox(height: 16),
                      BranchesDropdown(onBranchSelected: handleBranchSelection),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<BranchTopic>(
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
                        items: branchTopics.map((BranchTopic topic) {
                          return DropdownMenuItem<BranchTopic>(
                            value: topic,
                            child: Text(topic.name),
                          );
                        }).toList(),
                        onChanged: selectedBranch == null
                            ? null // Branş seçilmediyse konu dropdown'u tıklanamaz
                            : (BranchTopic? newValue) {
                                setState(() {
                                  selectedTopic = newValue;
                                });
                                print('Seçilen Konu: ${selectedTopic?.name}');
                              },
                        hint: const Text('Konu Seç'),
                        value:
                            selectedTopic, // Konu seçildiğinde burada görüntülenir
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<Region>(
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
                            provinces.clear();
                          });

                          if (newValue != null) {
                            print('Seçilen Bölge ID: ${newValue.id}');
                            print('Seçilen Bölge Adı: ${newValue.name}');
                            fetchProvince(newValue.id);
                          }
                        },
                        hint: const Text('İl Seç'),
                        value: selectedRegion,
                      ),
                      const SizedBox(height: 16),
                      // Saat Aralığı Dropdown
                      if (provinces.isNotEmpty)
                        DropdownButtonFormField<Province>(
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
                            });

                            if (newDistrict != null) {
                              print('Seçilen District ID: ${newDistrict.id}');
                              print(
                                  'Seçilen District Adı: ${newDistrict.name}');
                            }
                          },
                          hint: const Text('İlçe Seç'),
                          value: selectedProvince,
                        ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          text: "Ders Talep Et",
                          onPress: () {
                            if (selectedBranch != null &&
                                selectedTopic != null) {
                              context.read<RequestLessonBloc>().add(
                                  RequestLesson(
                                      request: CourseRequest(
                                          lessonId:
                                              selectedBranch!.id.toString(),
                                          cityId: selectedRegion!.id.toString(),
                                          schoolId: "1",
                                          name: "",
                                          message: "")));
                              print(
                                  'Talep edilen ders: ${selectedBranch?.name}');
                              print(
                                  'Talep edilen konu: ${selectedTopic?.name}');
                              print(
                                  'Talep edilen bölge: ${selectedRegion?.name}');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              state is RequestLessonLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox(),
            ],
          ),
        );
      }),
    );
  }
}
