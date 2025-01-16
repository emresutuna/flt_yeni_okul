import 'dart:async';
import 'package:baykurs/ui/filter/FilterSchool.dart';
import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/SharedPrefHelper.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../util/YOColors.dart';
import '../../widgets/CompanyListItem.dart';
import '../../widgets/SearchBar.dart';
import '../../widgets/infoWidget/InfoWidget.dart';
import 'bloc/SchoolBloc.dart';
import 'bloc/SchoolEvent.dart';
import 'bloc/SchoolState.dart';
import 'model/SchoolFilter.dart';
import 'model/SchoolResponse.dart';

class CompanyListPage extends StatefulWidget {
  const CompanyListPage({super.key});

  @override
  State<CompanyListPage> createState() => _CompanyListPageState();
}

class _CompanyListPageState extends State<CompanyListPage> {
  StreamController<List<SchoolItem>> _streamController =
      StreamController<List<SchoolItem>>.broadcast();
  List<String> searchResults = [];
  SchoolFilter schoolFilter = SchoolFilter();
  String query = "";
  bool hasLogin = false;
  final FocusNode _searchFocusNode = FocusNode();

  void onQueryChanged(String query) {
    this.query = query;
    if (query.length > 2) {
      context
          .read<SchoolBloc>()
          .add(SearchSchool(schoolFilter: schoolFilter.copyWith(query: query)));
    }
  }

  void onQueryCleared() {
    query = "";
    schoolFilter.copyWith(query: query);
    context.read<SchoolBloc>().add(FetchSchool());
  }

  @override
  void initState() {
    super.initState();
    loginController();
    context.read<SchoolBloc>().add(FetchSchool());
  }

  void loginController() async {
    final token = await getToken();
    if (token == null || token.isEmpty) {
      hasLogin = false;
    } else {
      hasLogin = true;
    }
  }

  void toggleFavorite(int index, List<SchoolItem> item) {
    item[index].isFav = !item[index].isFav!;
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
    _streamController.close();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Kurumlar"),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16, top: 16),
              child: InfoCardWidget(
                title: "Kurumlar",
                description:
                "Dilediğin kurumun profilini ziyaret ederek bilgi alabilir, sana uygun kurumları keşfedebilirsin. Favoriye aldığın kurumların eklediği ders ve kurslardan anında haberdar olabilirsin.",
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: YoSearchBar(
                    focusNode: _searchFocusNode,
                    onQueryChanged: onQueryChanged,
                    onClearCallback: onQueryCleared,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () async {
                      final filter = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FilterSchool(
                                  currentFilter: schoolFilter,
                                ),
                            fullscreenDialog: true),
                      ) as SchoolFilter?;

                      if (filter != null) {
                        schoolFilter = filter;
                        if (mounted) {
                          context.read<SchoolBloc>().add(SearchSchool(
                              schoolFilter:
                                  schoolFilter.copyWith(query: query)));
                        }
                      }
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
              child: GestureDetector(
                onPanDown: (_) {
                  _searchFocusNode.unfocus();
                },
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
                      return  Center(child: CircularProgressIndicator(color: color5,));
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
                    return  Center(child: CircularProgressIndicator(color: color5,));
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
                      crossAxisSpacing: 16.0,
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
                          isFavorite: hasLogin ? schoolList[index].isFav : null,
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
