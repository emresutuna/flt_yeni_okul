import 'dart:async';
import 'package:baykurs/ui/favoriteschool/bloc/FavoriteSchoolBloc.dart';
import 'package:baykurs/ui/favoriteschool/bloc/FavoriteSchoolEvent.dart';
import 'package:baykurs/ui/favoriteschool/bloc/FavoriteSchoolState.dart';
import 'package:baykurs/ui/favoriteschool/model/FavoriteSchoolResponse.dart';
import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/CompanyListItem.dart';
import '../../widgets/ErrorWidget.dart';
import '../../widgets/WhiteAppBar.dart';

class FavoriteSchoolPage extends StatefulWidget {
  const FavoriteSchoolPage({super.key});

  @override
  State<FavoriteSchoolPage> createState() => _FavoriteSchoolPageState();
}

class _FavoriteSchoolPageState extends State<FavoriteSchoolPage> {
  FavoriteSchoolResponse? favoriteSchoolResponse;
  final StreamController<List<SchoolList>> _streamController =
  StreamController<List<SchoolList>>();

  @override
  void initState() {
    super.initState();
    context.read<FavoriteSchoolBloc>().add(FetchFavorites());
  }

  void toggleFavorite(int index, List<SchoolList> item) {
    item.removeWhere((data) => data.id == item[index].id);
    _streamController.add(List<SchoolList>.from(item));
    context
        .read<FavoriteSchoolBloc>()
        .add(ToggleFavorite(schoolId: item[index].school!.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Favori Kurumlar"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.start,
                "Favori kurumları görüntüleyebilir detayına tıklayarak kuruma ait ders programını görüntüleyebilirsin.",
                style: styleBlack14Regular,
              ),
              16.toHeight,
              Expanded(
                child: BlocConsumer<FavoriteSchoolBloc, FavoriteSchoolState>(
                  listener: (context, state) {
                    if (state is FavoriteSchoolError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Bir hata oluştu: ${state.error}'),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is FavoriteSchoolSuccess) {
                      favoriteSchoolResponse = state.favoriteSchoolResponse;
                      if (!_streamController.hasListener) {
                        _streamController.add(favoriteSchoolResponse!.data!);
                      }
                      return Padding(
                        padding: const EdgeInsets.only(left: 0.0, right: 0, top: 8),
                        child: StreamBuilder<List<SchoolList>>(
                          stream: _streamController.stream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                    'Bir hata oluştu: ${snapshot.error}'),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const BkErrorWidget(
                                title: "Bilgi",
                                description:
                                "Şuanda hiçbir kurumu favoriye almadınız",
                              );
                            }

                            List<SchoolList> schoolList = snapshot.data!;

                            return GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: schoolList.length,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 16,
                                crossAxisCount: 2,
                                crossAxisSpacing: 24.0,
                                childAspectRatio: 2 / 2.7,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/companyDetail',
                                      arguments: schoolList[index].id,
                                    );
                                  },
                                  child: CompanyListItem(
                                    icon: schoolList[index].school!.photo ?? "",
                                    name:
                                    schoolList[index].school!.user!.name!,
                                    isFavorite:
                                    schoolList[index].school!.isFav!,
                                    province: schoolList[index]
                                        .school!
                                        .cityId!
                                        .toString(),
                                    city: schoolList[index]
                                        .school!
                                        .cityId!
                                        .toString(),
                                    onFavoriteClick: () {
                                      toggleFavorite(index, schoolList);
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    } else if (state is FavoriteSchoolLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is FavoriteSchoolError) {
                      return const BkErrorWidget(
                        title: "Hata",
                        description: "Şuanda hiçbir kurum favoriye almadınız",
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
