import 'dart:async';
import 'package:baykurs/util/SizedBoxExtension.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../util/YOColors.dart';
import '../../widgets/CompanyListFilterBottomSheet.dart';
import '../../widgets/CompanyListItem.dart';
import '../../widgets/SearchBar.dart';
import 'bloc/SchoolBloc.dart';
import 'bloc/SchoolEvent.dart';
import 'bloc/SchoolState.dart';
import 'model/SchoolResponse.dart';

class CompanyListPage extends StatefulWidget {
  const CompanyListPage({super.key});

  @override
  State<CompanyListPage> createState() => _CompanyListPageState();
}

class _CompanyListPageState extends State<CompanyListPage> {
  List<String> data = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grapes',
    'Honeydew',
    'Kiwi',
    'Lemon',
  ];
  StreamController<List<SchoolItem>> _streamController =
      StreamController<List<SchoolItem>>.broadcast();
  List<String> searchResults = [];

  void onQueryChanged(String query) {
    if (query.length > 2) {
      context.read<SchoolBloc>().add(SearchSchool(queryText: query));
    }
  }

  void onQueryCleared() {
    context.read<SchoolBloc>().add(FetchSchool());
  }

  @override
  void initState() {
    super.initState();
    context.read<SchoolBloc>().add(FetchSchool());
  }

  void toggleFavorite(int index, List<SchoolItem> item) {
    item[index].isFav = !item[index].isFav;
    _streamController.add(List<SchoolItem>.from(item));
    context.read<SchoolBloc>().add(ToggleFavorite(schoolId: item[index].id));
  }

  void updateSchoolList(List<SchoolItem> schools) {
    if (!_streamController.isClosed) {
      _streamController.sink.close();
    }
    _streamController = StreamController<List<SchoolItem>>();
    _streamController.sink.add(schools);
  }
  @override
  void dispose() {
    super.dispose();
    _streamController.close();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Kurumlar"),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 24, right: 16),
              child: Text(
                "Dilediğin kurumun profilini ziyaret ederek bilgi alabilir, sana uygun kurumları keşfedebilirsin. Favoriye eklediğin kurumların yayınladığı derslere, “Ders Bul” özelliğiyle kolayca erişebilirsin.",
                style: styleBlack12Bold,
                textAlign: TextAlign.start,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: YoSearchBar(
                    onQueryChanged: onQueryChanged,
                    onClear: onQueryCleared,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      showCompanyFilterBottomSheet(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(left: 0, right: 16),
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: color5,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Image.asset(
                          "assets/ic_filter.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: BlocConsumer<SchoolBloc, SchoolState>(
                listener: (context, state) {
                  if (state is FavoriteError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Bir hata oluştu: ${state.error}')),
                    );
                  }
                },
                buildWhen: (context, state) {
                  return state is SchoolLoading ||
                      state is SchoolSuccess ||
                      state is SchoolError ||
                      state is SchoolDefault;
                },
                builder: (context, state) {
                  if (state is SchoolLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SchoolSuccess) {
                    updateSchoolList(state.schoolResponse.data.schools);
                    return buildSchoolList();
                  } else if (state is SchoolError) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSchoolList() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
              child: StreamBuilder<List<SchoolItem>>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('Bir hata oluştu: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Veri bulunamadı'));
                  }

                  List<SchoolItem> schoolList = snapshot.data!;

                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    primary: true,
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
                          icon: schoolList[index].photo ?? "",
                          name: schoolList[index].user.name,
                          isFavorite: schoolList[index].isFav,
                          province: schoolList[index].city.province.name,
                          city: schoolList[index].city.name,
                          onFavoriteClick: () {
                            toggleFavorite(index, schoolList);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          24.toHeight
        ],
      ),
    );
  }
}
