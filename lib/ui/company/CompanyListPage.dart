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

  List<String> searchResults = [];

  void onQueryChanged(String query) {
    setState(() {
      searchResults = data
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<SchoolBloc>().add(FetchSchool());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<SchoolBloc, SchoolState>(builder: (context, state) {
        if (state is SchoolLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SchoolSuccess) {
          List<School> schoolList = state.schoolResponse.data?.data ?? [];
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8),
                  child: Row(
                    children: [
                      InkWell(
                        child: Icon(Icons.arrow_back_ios),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        "Kurumlar",
                        style: styleBlack16Bold,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 24,right: 16),
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
                        child: YoSearchBar(onQueryChanged: onQueryChanged)),
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
                              color: color5),
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
                    child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      primary: true,
                      itemCount: schoolList.length ?? 0,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 16,
                        crossAxisCount: 2,
                        crossAxisSpacing: 24.0,
                        childAspectRatio: 2 / 2.7,
                      ),
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/companyDetail', arguments: schoolList[index].id);
                            },
                            child: CompanyListItem(
                              icon: schoolList[index].photo ?? "",
                              name: schoolList[index].user?.name ?? "",
                              isFavorite: false,
                              province: schoolList[index].province?.name ?? "",
                              city: schoolList[index].city?.name ?? "",
                            ),
                          )),
                )),
              ],
            ),
          );
        } else if (state is SchoolError) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return Center(child: Text('No courses available'));
        }
      }),
    );
  }
}
