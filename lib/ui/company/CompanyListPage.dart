import 'package:flutter/material.dart';
import 'package:yeni_okul/ui/company/model/CompanyModel.dart';
import 'package:yeni_okul/util/YOColors.dart';
import 'package:yeni_okul/widgets/CompanyListFilterBottomSheet.dart';
import 'package:yeni_okul/widgets/SearchBar.dart';
import 'package:yeni_okul/widgets/YOText.dart';

import '../../util/HexColor.dart';
import '../../widgets/CompanyListItem.dart';
import '../../widgets/YOAppBar.dart';

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
  List<CompanyModel> companyList = [
    CompanyModel(
        id: 1,
        companyId: 1,
        companyName: "Esenler Açı Dershanesi",
        companyDesc: "Esenler Açı Dershanesia",
        companyTitle: "title",
        companyPhoto: "assets/company_logo.jpg",
        companyLocation: [43.12312, 31.2131],
        teacherList: null),
    CompanyModel(
        id: 2,
        companyId: 2,
        companyName: "Fatih Sınav Dershanesi",
        companyDesc: "Fatih sınav açıklama",
        companyTitle: "title",
        companyPhoto: "assets/company_logo.jpg",
        companyLocation: [43.12312, 31.2131],
        teacherList: null),
    CompanyModel(
        id: 3,
        companyId: 3,
        companyName: "Güngören Birey Dershanesi",
        companyDesc: "Güngören Birey Dershanesi",
        companyTitle: "title",
        companyPhoto: "assets/company_logo.jpg",
        companyLocation: [43.12312, 31.2131],
        teacherList: null),
    CompanyModel(
        id: 4,
        companyId: 4,
        companyName: "Sultangazi Limit Eğitim Kurumları",
        companyDesc: "Sultangazi Limit Eğitim Kurumları",
        companyTitle: "title",
        companyPhoto: "assets/company_logo.jpg",
        companyLocation: [43.12312, 31.2131],
        teacherList: null),
    CompanyModel(
        id: 4,
        companyId: 4,
        companyName: "Sultangazi Limit Eğitim Kurumları",
        companyDesc: "Sultangazi Limit Eğitim Kurumları",
        companyTitle: "title",
        companyPhoto: "assets/company_logo.jpg",
        companyLocation: [43.12312, 31.2131],
        teacherList: null),
    CompanyModel(
        id: 4,
        companyId: 4,
        companyName: "Sultangazi Limit Eğitim Kurumları",
        companyDesc: "Sultangazi Limit Eğitim Kurumları",
        companyTitle: "title",
        companyPhoto: "assets/company_logo.jpg",
        companyLocation: [43.12312, 31.2131],
        teacherList: null),
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
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> key = GlobalKey();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: YOAppBar(
        enableBackButton: true,
        drawerKey: key,
      ),
      body: SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.only(top: 90),
            decoration: gradient,
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16.0,
                        top: 8,
                      ),
                      child: YoText(
                        text: "Kurumlar",
                        size: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: YoSearchBar(onQueryChanged: onQueryChanged)),
                    Expanded(
                      flex: 1,
                      child: InkWell(onTap: (){
                        showCompanyFilterBottomSheet(context);
                      },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(left: 0, right: 16),
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    HexColor("#F2AF47"),
                                    HexColor("#FFDDA8")
                                  ])),
                          child: Image.asset(
                            "assets/ic_filter.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        primary: true,
                        itemCount: companyList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 0,
                          crossAxisCount: 2,
                          crossAxisSpacing: 24.0,
                          childAspectRatio: 2 / 2.7,
                        ),
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {

                                  Navigator.pushNamed(context, '/companyDetail');

                              },
                              child: CompanyListItem(
                                icon: companyList[index].companyPhoto!,
                                name: companyList[index].companyName!,
                                isFavorite: false,
                              ),
                            ))),
              ],
            ),
          )),
    );
  }
}
