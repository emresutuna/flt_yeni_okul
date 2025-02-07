import 'dart:async';
import 'package:baykurs/ui/filter/FilterSchool.dart';
import 'package:baykurs/util/SharedPrefHelper.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../util/FirebaseAnalyticsConstants.dart';
import '../../util/FirebaseAnalyticsManager.dart';
import '../../util/GlobalLoading.dart';
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
  final StreamController<List<SchoolItem>> _streamController =
      StreamController<List<SchoolItem>>.broadcast();
  final ScrollController _scrollController = ScrollController();
  final List<SchoolItem> _schoolList = [];
  SchoolFilter schoolFilter = SchoolFilter();
  String query = "";
  bool hasLogin = false;
  bool isLoading = false;
  bool hasMoreData = true;
  int currentPage = 1;
  final int pageSize = 10;
  final FocusNode _searchFocusNode = FocusNode();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    loginController();
    fetchSchools();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !isLoading &&
          hasMoreData) {
        _debounce(() {
          fetchSchools();
        }, const Duration(milliseconds: 400));
      }
    });
  }

  void _debounce(VoidCallback action, Duration delay) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    _debounceTimer = Timer(delay, action);
  }

  void onQueryChanged(String query) {
    this.query = query;
    if (query.length > 2) {
      currentPage = 1;
      schoolFilter = schoolFilter.copyWith(
          query: query, currentPage: currentPage.toString());
      resetPagination();
      FirebaseAnalyticsManager.logEvent(FirebaseAnalyticsConstants.school_search);
      fetchSchools(isSearch: true);
    }
  }

  Future<void> fetchSchools(
      {bool isSearch = false, bool isFilter = false}) async {
    if (isLoading || !hasMoreData)
      return;

    setState(() {
      isLoading = true;
    });

    context.read<SchoolBloc>().add(SearchSchool(
          schoolFilter:
              schoolFilter.copyWith(currentPage: currentPage.toString()),
        ));

    context.read<SchoolBloc>().stream.listen((state) {
      if (state is SchoolSuccess) {
        final newSchools = state.schoolResponse.data.schools;
        final apiCurrentPage =
            state.schoolResponse.data.currentPage;

        if (newSchools.isEmpty) {
          hasMoreData = false;
        } else {
          if (isSearch || isFilter) {
            _schoolList.clear();
            _streamController.sink.add([]);
            hasMoreData = true;
          }

          _schoolList.addAll(newSchools);
          _streamController.sink
              .add(_schoolList);

          if (apiCurrentPage == currentPage) {
            currentPage++;
          }
        }
      } else if (state is SchoolError) {
        _streamController.addError(state.error);
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  void onQueryCleared() {
    query = "";
    currentPage = 1;
    schoolFilter = schoolFilter.copyWith(query: query);
    resetPagination();
    fetchSchools();
  }

  void resetPagination() {
    currentPage = 1;
    hasMoreData = true;
    _schoolList.clear();
    _streamController.sink.add([]);
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  void loginController() async {
    final token = await getToken();
    if (token == null || token.isEmpty) {
      hasLogin = false;
    } else {
      hasLogin = true;
    }
  }

  void toggleFavorite(int index) {
    _schoolList[index].isFav = !_schoolList[index].isFav!;
    _streamController.sink.add(List<SchoolItem>.from(_schoolList));
    context
        .read<SchoolBloc>()
        .add(ToggleFavorite(schoolId: _schoolList[index].id));
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _streamController.close();
    _scrollController.removeListener(() {});
    _scrollController.dispose();
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
                      FirebaseAnalyticsManager.logEvent(FirebaseAnalyticsConstants.school_filter);
                      final filter = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilterSchool(
                            currentFilter: schoolFilter,
                          ),
                          fullscreenDialog: true,
                        ),
                      ) as SchoolFilter?;

                      if (filter != null) {
                        schoolFilter = filter;
                        resetPagination();
                        fetchSchools(
                            isFilter: true);
                        print("MEVCUT SAYFA: ${currentPage}");
                      } else {
                        resetPagination();
                      }
                      print("MEVCUT SAYFA: ${currentPage}");
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
                child: StreamBuilder<List<SchoolItem>>(
                  stream: _streamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        _schoolList.isEmpty) {
                      return const GlobalFadeAnimation();
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Bir hata oluştu: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Veri bulunamadı'));
                    }

                    return buildSchoolList(snapshot.data!);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSchoolList(List<SchoolItem> schoolList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 2 / 2.7,
        ),
        itemCount: schoolList.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == schoolList.length) {
            return const GlobalFadeAnimation();
          }

          final school = schoolList[index];
          return InkWell(
            onTap: () {
              FirebaseAnalyticsManager.logEvent(FirebaseAnalyticsConstants.school_detail_click, parameters: {
                "schoolName": school.user.name,
                "schoolId": school.user.id,
              });
              Navigator.pushNamed(
                context,
                '/companyDetail',
                arguments: school.id,
              ).then((value) {
                resetPagination();
                fetchSchools();
              });
            },
            child: CompanyListItem(
              icon: school.photo ?? "",
              name: school.user.name,
              isFavorite: hasLogin ? school.isFav : null,
              province: school.city.province.name,
              city: school.city.name,
              onFavoriteClick: () {
                toggleFavorite(index);
              },
            ),
          );
        },
      ),
    );
  }
}
