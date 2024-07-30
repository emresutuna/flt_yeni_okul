import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yeni_okul/ui/company/model/CompanyModel.dart';
import 'package:yeni_okul/ui/course/model/CourseModel.dart';
import 'package:yeni_okul/widgets/CourseListItem.dart';
import '../../util/YOColors.dart';
import '../../widgets/CompanyListFilterBottomSheet.dart';
import '../../widgets/SearchBar.dart';
import '../../widgets/YOText.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
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
  List<CourseModel> courseList = [
    CourseModel(
        id: 1,
        courseId: 1,
        courseName: "Köklü Sayılar",
        courseTitle: "Köklü Sayılar",
        courseDesc: "Köklü sayılar ders anlatımı",
        courseType: "Matematik",
        date: "23.04.23",
        startDate: "24.04.23",
        endDate: "24.04.23",
        hasPackageCourse: false,
        time: "14:00",
        quota: "5 kişi",
        price: "100₺",
        location: "Esenler/İstanbul",
        teacher: Teacher(
            id: 1,
            teacherName: "Tamer",
            teacherSurname: "Yüksel",
            teacherBranch: "Matematik"),
        company: CompanyModel(
            id: 1,
            companyId: 1,
            companyName: "Esenler Açı Dershanesi",
            companyDesc: "Esenler Açı Dershanesia",
            companyTitle: "title",
            companyPhoto: "assets/company_logo.jpg",
            companyLocation: [43.12312, 31.2131],
            teacherList: null))
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
                    child: const Icon(Icons.arrow_back_ios),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "Dersler",
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
                child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return CourseListItem();
              },
            )),
          ],
        ),
      ),
    );
  }

  Widget courseItem(String firstIcon, String firstLabel, String secondIcon,
      String secondLabel) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          courseLabel(firstIcon, firstLabel),
          courseLabel(secondIcon, secondLabel),
        ],
      ),
    );
  }

  Widget courseLabel(String icon, String label) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Wrap(
        spacing: 12,
        alignment: WrapAlignment.end,
        clipBehavior: Clip.antiAlias,
        crossAxisAlignment: WrapCrossAlignment.end,
        direction: Axis.horizontal,
        verticalDirection: VerticalDirection.up,
        runAlignment: WrapAlignment.end,
        children: [
          const SizedBox(
            width: 4,
          ),
          ListTile(
            isThreeLine: false,
            minLeadingWidth: 0,
            minVerticalPadding: 0,
            dense: true,
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(vertical: -3),
            leading: Image.asset(icon),
            titleAlignment: ListTileTitleAlignment.center,
            title: Transform.translate(
              offset: const Offset(-32, 0),
              child: YoText(
                text: label,
                size: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
