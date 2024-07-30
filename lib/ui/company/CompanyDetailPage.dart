import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yeni_okul/ui/company/model/CompanyModel.dart';
import 'package:yeni_okul/util/HexColor.dart';
import 'package:yeni_okul/widgets/ExpandedWidget.dart';
import 'package:yeni_okul/widgets/TeacherListItem.dart';
import '../../util/YOColors.dart';
import '../../widgets/YOAppBar.dart';
import '../../widgets/YOText.dart';
import '../../widgets/YellowBox.dart';

class CompanyDetailPage extends StatefulWidget {
  const CompanyDetailPage({super.key});

  @override
  State<CompanyDetailPage> createState() => _CompanyDetailPageState();
}

class _CompanyDetailPageState extends State<CompanyDetailPage> {
  List<Teacher> teacherList = [
    Teacher(
        id: 1,
        teacherName: "Tamer",
        teacherSurname: "Yüksel",
        teacherBranch: "Matematik"),
    Teacher(
        id: 1,
        teacherName: "Tamer",
        teacherSurname: "Yüksel",
        teacherBranch: "Matematik"),
    Teacher(
        id: 1,
        teacherName: "Tamer",
        teacherSurname: "Yüksel",
        teacherBranch: "Matematik"),
    Teacher(
        id: 1,
        teacherName: "Tamer",
        teacherSurname: "Yüksel",
        teacherBranch: "Matematik"),
    Teacher(
        id: 1,
        teacherName: "Tamer",
        teacherSurname: "Yüksel",
        teacherBranch: "Matematik"),
    Teacher(
        id: 1,
        teacherName: "Tamer",
        teacherSurname: "Yüksel",
        teacherBranch: "Matematik"),
    Teacher(
        id: 1,
        teacherName: "Tamer",
        teacherSurname: "Yüksel",
        teacherBranch: "Matematik")
  ];
  double _originLatitude = 41.0387173;
  double _originLongitude = 28.8824411;

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> key = GlobalKey();
    GoogleMapController _controller;
    final CameraPosition _initalCameraPosition = CameraPosition(
      target: LatLng(_originLatitude, _originLongitude),
      zoom: 15,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: const Icon(Icons.arrow_back_ios),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      "Esenler Açı Dershanesi",
                      style: styleBlack16Bold,
                    ),
                    const Spacer(flex: 2),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: InkWell(
                        child: const Icon(Icons.favorite_outline),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
                child: Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 0.5,
                        color: color2,
                      )),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/company_logo2.png",
                        fit: BoxFit.fill,
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 24),
                child: Text(
                  "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s Lorem Ipsum has been the industry's standard dummy text ever since the 1500s Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                  style: styleBlack14Bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 0.5,
                        color: color2,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, "/courseListPage");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dersleri Görüntüle",
                                style: styleBlack14Bold,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  "Kuruma ait dersleri Görüntüle",
                                  style: styleBlack12Regular,
                                ),
                              )
                            ],
                          ),
                          Icon(Icons.arrow_circle_right_outlined)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ExpandedWidget(
                  title: const Align(
                      alignment: Alignment.centerLeft,
                      child: YoText(
                        text: "Öğretmenler",
                        size: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  children: GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      primary: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: teacherList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 0,
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 1.2,
                      ),
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/companyDetail');
                            },
                            child: TeacherListItem(
                              teacherName:
                                  "${teacherList[index].teacherName!} ${teacherList[index].teacherSurname!}",
                              teacherBranch: teacherList[index].teacherBranch!,
                            ),
                          ))),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ExpandedWidget(
                    title: const Align(
                        alignment: Alignment.centerLeft,
                        child: YoText(
                          text: "Konum",
                          size: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    children: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Adres: Fevzi Çakmak, 1107. Sk. No:15, 34230 Esenler/İstanbul",
                            style: styleBlack12Bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                          child: GoogleMap(
                            myLocationButtonEnabled: true,
                            mapType: MapType.normal,
                            initialCameraPosition: _initalCameraPosition,
                            tiltGesturesEnabled: true,
                            compassEnabled: true,
                            scrollGesturesEnabled: true,
                            zoomGesturesEnabled: true,
                            onMapCreated: (GoogleMapController controller) {
                              _controller = controller;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
