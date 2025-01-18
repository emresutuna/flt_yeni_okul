import 'dart:async';

import 'package:baykurs/util/AllExtension.dart';
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
  StreamController<bool> _streamController = StreamController<bool>.broadcast();

  void toggleFavorite(int id, bool isFav) {
    isFav = !isFav;
    _streamController.add(isFav);
    context.read<SchoolDetailBloc>().add(ToggleFavorite(schoolId: id));
  }

  void updateSchoolList(bool schools) {
    if (!_streamController.isClosed) {
      _streamController.sink.close();
    }
    _streamController = StreamController<bool>();
    _streamController.sink.add(schools);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context) != null) {
      companyId = ModalRoute
          .of(context)!
          .settings
          .arguments as int;
      context.read<SchoolDetailBloc>().add(FetchSchoolById(id: companyId));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
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
              return Center(
                  child: CircularProgressIndicator(
                    color: color5,
                  ));
            } else if (state is SchoolDetailSuccess) {
              teacherList = state.schoolResponse.data?.teachers ?? [];
              updateSchoolList(state.schoolResponse.data?.isFav??false);

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 8),
                        child: Row(
                          children: [
                            InkWell(
                              child: const Icon(Icons.arrow_back_ios),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            8.toWidth,
                            Expanded(
                              child: Text(
                                state.schoolResponse.data?.user?.name ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: styleBlack14Bold,
                              ),
                            ),
                            8.toWidth,
                            StreamBuilder<bool>(
                                stream: _streamController.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator(
                                          color: color5,));
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child: Text('Bir hata oluştu: ${snapshot
                                            .error}'));
                                  } else
                                  if (!snapshot.hasData || snapshot.data!) {
                                    return InkWell(
                                      child: Icon(
                                        snapshot.data == true
                                            ? Icons.favorite
                                            : Icons.favorite_outline,
                                        color: color5,
                                      ),
                                      onTap: () {
                                        toggleFavorite(
                                            state.schoolResponse.data?.id ?? -1,
                                            snapshot.data ??
                                                false);
                                      },
                                    );
                                  } else {
                                    return InkWell(
                                      child: Icon(
                                        snapshot.data == true
                                            ? Icons.favorite
                                            : Icons.favorite_outline,
                                        color: color5,
                                      ),
                                      onTap: () {
                                        toggleFavorite(
                                            state.schoolResponse.data?.id ?? -1,
                                            snapshot.data??
                                                false);
                                      },
                                    );
                                  }
                                }
                            ),
                            16.toWidth

                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 24),
                        child: Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 4,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
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
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
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
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        "Dersleri Görüntüle",
                                        style: styleBlack14Bold,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 6.0),
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
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
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
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        "Kursları Görüntüle",
                                        style: styleBlack14Bold,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 6.0),
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
                              itemBuilder: (context, index) =>
                                  TeacherListItem(
                                    teacherName:
                                    "${teacherList[index]
                                        .userId!} ${teacherList[index]
                                        .schoolId!}",
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
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 4,
                                  child: GoogleMap(
                                    myLocationButtonEnabled: true,
                                    mapType: MapType.normal,
                                    initialCameraPosition: _initalCameraPosition,
                                    tiltGesturesEnabled: true,
                                    compassEnabled: true,
                                    scrollGesturesEnabled: true,
                                    zoomGesturesEnabled: true,
                                    onMapCreated: (
                                        GoogleMapController controller) {
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
