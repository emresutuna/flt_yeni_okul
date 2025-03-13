import 'dart:async';
import 'package:baykurs/util/AllExtension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baykurs/ui/filter/filter_school.dart';
import 'package:baykurs/util/FirebaseAnalyticsConstants.dart';
import 'package:baykurs/util/FirebaseAnalyticsManager.dart';
import 'package:baykurs/util/SharedPrefHelper.dart';
import '../../util/YOColors.dart';
import '../../widgets/SearchBar.dart';
import '../../widgets/CompanyListItem.dart';
import '../../widgets/WhiteAppBar.dart';
import '../../widgets/infoWidget/InfoWidget.dart';
import 'bloc/school_bloc.dart';
import 'bloc/school_state.dart';
import 'model/company_list_manager.dart';
import 'model/company_list_notifier.dart';
import 'model/school_filter.dart';

class CompanyListPage extends StatefulWidget {
  const CompanyListPage({super.key});

  @override
  State<CompanyListPage> createState() => _CompanyListPageState();
}

class _CompanyListPageState extends State<CompanyListPage> {
  late CompanyListManager companyListManager;
  final CompanyListNotifier notifier = CompanyListNotifier();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _searchFocusNode = FocusNode();
  SchoolFilter schoolFilter = SchoolFilter();
  Timer? _searchDebounce;
  bool hasLogin = false;

  @override
  void initState() {
    super.initState();
    companyListManager = CompanyListManager(
      schoolBloc: context.read<SchoolBloc>(),
      setState: setState,
    );

    _checkLoginStatus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialData();
    });

    _scrollController.addListener(_onScroll);
  }

  Future<void> _checkLoginStatus() async {
    final token = await getToken();
    setState(() {
      hasLogin = token != null && token.isNotEmpty;
    });
  }

  void _fetchInitialData() {
    companyListManager.fetchSchools(filter: schoolFilter, searchQuery: "");
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      companyListManager.loadMoreSchools(schoolFilter);
    }
  }

  void _onSearchChangedWithDebounce(String query) {
    if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      _onSearchChanged(query);
    });
  }

  void _onSearchChanged(String query) {
    if (query.length < 3) return;

    setState(() {
      notifier.setLoading(true);
      companyListManager.resetPagination();
      companyListManager.schoolList.clear();
    });

    FirebaseAnalyticsManager.logEvent(FirebaseAnalyticsConstants.school_search);
    companyListManager.fetchSchools(filter: schoolFilter, searchQuery: query);
  }

  void _onSearchCleared() {
    setState(() {
      notifier.setLoading(true);
      companyListManager.resetPagination();
      companyListManager.schoolList.clear();
    });

    companyListManager.fetchSchools(filter: schoolFilter, searchQuery: "");
  }

  void _handleFilterChange(SchoolFilter newFilter) {
    setState(() {
      notifier.setLoading(true);
      schoolFilter = newFilter;
      companyListManager.resetPagination();
      companyListManager.schoolList.clear();
    });

    companyListManager.fetchSchools(filter: schoolFilter, searchQuery: companyListManager.query);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchFocusNode.dispose();
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Kurumlar"),
      body: SafeArea(
        child: BlocListener<SchoolBloc, SchoolState>(
          listener: (context, state) {
            if (state is SchoolSuccess) {
              companyListManager.updateSchoolList(state.schoolResponse.data.schools);
              notifier.setLoading(false);
            }
          },
          child: Column(
            children: [
              _buildHeader(),
              _buildSearchBar(),
              Expanded(
                child: ListenableBuilder(
                  listenable: notifier,
                  builder: (context, child) {
                    return _buildCompanyGrid();
                  },
                ),
              ),
              16.toHeight
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: InfoCardWidget(
        title: "Kurumlar",
        description: "Kurumların profilini ziyaret ederek bilgi alabilir, sana uygun kurumları keşfedebilirsin.",
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: YoSearchBar(
            onQueryChanged: _onSearchChangedWithDebounce,
            onClearCallback: _onSearchCleared,
            focusNode: _searchFocusNode,
          ),
        ),
        InkWell(
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
              _handleFilterChange(filter);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(left: 8, right: 16),
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color5,
            ),
            child: Image.asset("assets/ic_filter.png"),
          ),
        ),
      ],
    );
  }


  Widget _buildCompanyGrid() {
    if (notifier.isPageLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (companyListManager.schoolList.isEmpty) {
      return const Center(
        child: Text('Aktif kurum bulunamadı.', style: TextStyle(fontSize: 16)),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // ✅ 2 columns per row
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 2 / 2.7, // ✅ Maintain aspect ratio
        ),
        itemCount: companyListManager.schoolList.length + (notifier.isPageLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == companyListManager.schoolList.length) {
            return const Center(child: CircularProgressIndicator()); // ✅ Show loading
          }

          final school = companyListManager.schoolList[index];
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
              ).then((_) {
                companyListManager.resetPagination();
                companyListManager.fetchSchools(filter: schoolFilter, searchQuery: companyListManager.query);
              });
            },
            child: CompanyListItem(
              icon: school.photo ?? "",
              name: school.user.name,
              isFavorite: hasLogin ? school.isFav : null,
              province: school.city.province.name,
              city: school.city.name,
              onFavoriteClick: hasLogin ? () => companyListManager.toggleFavorite(index) : () {},
            ),
          );
        },
      ),
    );
  }

}
