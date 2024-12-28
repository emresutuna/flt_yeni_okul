import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../util/YOColors.dart';
import '../../widgets/ErrorWidget.dart';
import '../../widgets/ExpandedWidget.dart';
import '../../widgets/TeacherListItem.dart';
import '../../widgets/YOText.dart';
import 'bloc/SchoolDetailBloc.dart';
import 'bloc/SchoolDetailEvent.dart';
import 'bloc/SchoolDetailState.dart';
import 'model/SchoolDetailResponse.dart';

class CompanyDetailPage extends StatefulWidget {
  const CompanyDetailPage({super.key});

  @override
  State<CompanyDetailPage> createState() => _CompanyDetailPageState();
}

class _CompanyDetailPageState extends State<CompanyDetailPage> {
  late int companyId;
  final double _originLatitude = 41.0387173;
  final double _originLongitude = 28.8824411;
  List<Teachers> teacherList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context) != null) {
      companyId = ModalRoute.of(context)!.settings.arguments as int;
      context.read<SchoolDetailBloc>().add(FetchSchoolById(id: companyId));
    }
  }

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
      body: BlocBuilder<SchoolDetailBloc, SchoolDetailState>(
          builder: (context, state) {
        if (state is SchoolDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SchoolDetailSuccess) {
          teacherList = state.schoolResponse.data?.teachers ?? [];
          return SafeArea(
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
                          state.schoolResponse.data?.user?.name ?? "",
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
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 24),
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
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 24),
                    child: Text(
                      state.schoolResponse.data?.description ?? "",
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
                          onTap: () {
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
                                      "Kuruma ait dersleri görüntüle",
                                      style: styleBlack12Regular,
                                    ),
                                  )
                                ],
                              ),
                              const Icon(Icons.arrow_circle_right_outlined)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16, bottom: 16),
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
                          onTap: () {
                            Navigator.pushNamed(context, "/courseListPage");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kursları Görüntüle",
                                    style: styleBlack14Bold,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Text(
                                      "Kuruma ait kursları görüntüle",
                                      style: styleBlack12Regular,
                                    ),
                                  )
                                ],
                              ),
                              const Icon(Icons.arrow_circle_right_outlined)
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
                          itemBuilder: (context, index) => TeacherListItem(
                                teacherName:
                                    "${teacherList[index].userId!} ${teacherList[index].schoolId!}",
                                teacherBranch:
                                    teacherList[index].userId.toString(),
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
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
        } else if (state is SchoolDetailError) {
          return Container(
            child: Center(child: BkErrorWidget(
              onPress: () {
                Navigator.pop(context);
              },
            )),
          );
        } else {
          return const Center(child: Text('No courses available'));
        }
      }),
    );
  }
}
