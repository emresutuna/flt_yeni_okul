import 'dart:async';
import 'package:baykurs/util/AllExtension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../util/GlobalLoading.dart';
import '../../util/LessonExtension.dart';
import '../../util/SharedPrefHelper.dart';
import '../../util/YOColors.dart';
import '../../widgets/ErrorWidget.dart';
import '../../widgets/ExpandedWidget.dart';
import 'bloc/school_detail_bloc.dart';
import 'bloc/school_detail_event.dart';
import 'bloc/school_detail_state.dart';
import 'model/school_detail_response.dart';

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

  bool hasLogin = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context) != null) {
        companyId = ModalRoute.of(context)!.settings.arguments as int;
        context.read<SchoolDetailBloc>().add(FetchSchoolById(id: companyId));
      }
    });
  }

  Future<void> _checkLoginStatus() async {
    final token = await getToken();
    setState(() {
      hasLogin = token != null && token.isNotEmpty;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    GoogleMapController _controller;
    final CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(_originLatitude, _originLongitude),
      zoom: 15,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<SchoolDetailBloc, SchoolDetailState>(
          builder: (context, state) {
        if (state is SchoolDetailLoading) {
          return const GlobalFadeAnimation();
        } else if (state is SchoolDetailSuccess) {
          teacherList = state.schoolResponse.data?.teachers ?? [];
          updateSchoolList(state.schoolResponse.data?.isFav ?? false);

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
                            if (!hasLogin) {
                              return const SizedBox.shrink();
                            }

                            if (snapshot.hasError) {
                              return Center(child: Text(' ${snapshot.error}'));
                            }

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
                                  snapshot.data ?? false,
                                );
                              },
                            );
                          },
                        ),
                        16.toWidth
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 24),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3.8,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 0.5,
                          color: color2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          height: MediaQuery.of(context).size.height / 4.8,
                          imageUrl: state.schoolResponse.data?.photo ?? "",
                          fit: BoxFit.fill,
                          fadeInDuration: Duration.zero,
                          fadeOutDuration: Duration.zero,
                          placeholder: (context, url) => Center(
                            child: Image.asset(
                              "assets/placeholder.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: Image.asset(
                              "assets/placeholder.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
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
                            Navigator.pushNamed(context, "/courseListPage",
                                arguments: companyId);
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
                            Navigator.pushNamed(context, "/courseBundleList",
                                arguments: companyId);
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
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Öğretmenler",
                        style: styleBlack14Bold,
                      ),
                    ),
                    children: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: teacherList.length,
                      itemBuilder: (context, index) {
                        final teacher = teacherList[index];
                        final teacherName =
                            "${teacher.user?.name ?? ""} ${teacher.user?.surname ?? ""}";
                        final lessonName =
                            BranchesExtension.getBranchNameByLessonId(
                                teacher.lessonId);

                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: color2, width: 0.5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                spreadRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: color5.withOpacity(0.3),
                                ),
                                child: Icon(Icons.person,
                                    color: Colors.grey.shade600),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      teacherName,
                                      style: styleBlack14Bold,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      lessonName,
                                      style: styleBlack12Regular.copyWith(
                                          color: Colors.grey[700]),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ExpandedWidget(
                        title: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Konum",
                            style: styleBlack14Bold,
                          ),
                        ),
                        children: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                state.schoolResponse.data?.address ?? "",
                                style: styleBlack12Bold,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 4,
                              child: GoogleMap(
                                myLocationButtonEnabled: true,
                                mapType: MapType.normal,
                                initialCameraPosition: initialCameraPosition,
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
          return Center(child: BkErrorWidget(
            onPress: () {
              Navigator.pop(context);
            },
          ));
        } else {
          return const Center(child: Text('No courses available'));
        }
      }),
    );
  }
}
