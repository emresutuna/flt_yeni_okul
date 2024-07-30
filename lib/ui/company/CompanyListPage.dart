import 'package:flutter/material.dart';
import 'package:yeni_okul/ui/company/model/CompanyModel.dart';
import 'package:yeni_okul/util/YOColors.dart';
import 'package:yeni_okul/widgets/CompanyListFilterBottomSheet.dart';
import 'package:yeni_okul/widgets/SearchBar.dart';
import '../../widgets/CompanyListItem.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
              padding: const EdgeInsets.only(left: 16.0, top: 24),
              child: Text(
                "Lorem ipsum dolar sit amet",
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
                          color: color6),
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
                  itemCount: companyList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 16,
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
                      )),
            )),
          ],
        ),
      ),
    );
  }
}
