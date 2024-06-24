import 'package:flutter/material.dart';
import 'package:yeni_okul/ui/company/model/CompanyModel.dart';
import 'package:yeni_okul/util/HexColor.dart';
import 'package:yeni_okul/widgets/ExpandedWidget.dart';
import 'package:yeni_okul/widgets/TeacherListItem.dart';
import '../../util/YOColors.dart';
import '../../widgets/YOAppBar.dart';
import '../../widgets/YOText.dart';
import '../../widgets/YellowBox.dart';

class CompanyDetailPage extends StatefulWidget {
  const CompanyDetailPage({super.key});

  @override
  State<CompanyDetailPage> createState() => _CompanyDetailPageState();
}

class _CompanyDetailPageState extends State<CompanyDetailPage> {
  List<Teacher> teacherList = [
    Teacher(
        id: 1,
        teacherName: "Tamer",
        teacherSurname: "Yüksel",
        teacherBranch: "Matematik"),
    Teacher(
        id: 1,
        teacherName: "Tamer",
        teacherSurname: "Yüksel",
        teacherBranch: "Matematik"),
    Teacher(
        id: 1,
        teacherName: "Tamer",
        teacherSurname: "Yüksel",
        teacherBranch: "Matematik"),
    Teacher(
        id: 1,
        teacherName: "Tamer",
        teacherSurname: "Yüksel",
        teacherBranch: "Matematik"),
    Teacher(
        id: 1,
        teacherName: "Tamer",
        teacherSurname: "Yüksel",
        teacherBranch: "Matematik"),
    Teacher(
        id: 1,
        teacherName: "Tamer",
        teacherSurname: "Yüksel",
        teacherBranch: "Matematik"),
    Teacher(
        id: 1,
        teacherName: "Tamer",
        teacherSurname: "Yüksel",
        teacherBranch: "Matematik")
  ];

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
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 90),
              decoration: gradient,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 0.0,
                          color: HexColor("#F0F1FA"),
                        )),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/company_logo.jpg",
                          fit: BoxFit.fill,
                        )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: YoText(
                          text: "Esenler Açı Dershanesi",
                          fontWeight: FontWeight.bold,
                          size: 16,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: YoText(
                          textAlign: TextAlign.start,
                          text:
                              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s Lorem Ipsum has been the industry's standard dummy text ever since the 1500s Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                          size: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/courseListPage');
                        },
                        child: const YellowCard(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    YoText(
                                      text: "Dersleri Görüntüle",
                                      size: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: YoText(
                                          textAlign: TextAlign.start,
                                          size: 12,
                                          text:
                                              "Bu dersahaneye ait dersleri kolayca görüntüleyebilirsiniz"),
                                    )
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.only(right: 16.0),
                              child: Center(
                                child: Icon(Icons.arrow_circle_right_outlined),
                              ),
                            )
                          ],
                        )),
                      ),
                      ExpandedWidget(
                          title: const Align(
                              alignment: Alignment.centerLeft,
                              child: YoText(
                                text: "Öğretmenler",
                                size: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          children: GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: teacherList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 0,
                                crossAxisCount: 3,
                                crossAxisSpacing: 4.0,
                                childAspectRatio: 1.2,
                              ),
                              itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/companyDetail');
                                    },
                                    child: TeacherListItem(
                                      teacherName:
                                          "${teacherList[index].teacherName!} ${teacherList[index].teacherSurname!}",
                                      teacherBranch:
                                          teacherList[index].teacherBranch!,
                                    ),
                                  ))),
                      const ExpandedWidget(
                          title: Align(
                              alignment: Alignment.centerLeft,
                              child: YoText(
                                text: "Konum",
                                size: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          children: TeacherListItem(
                              teacherName: "Tamer Yüksel",
                              teacherBranch: "Matematik")),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
