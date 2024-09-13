import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:yeni_okul/ui/HomePageViewModel.dart';
import 'package:yeni_okul/ui/model/QuickActionModel.dart';
import 'package:yeni_okul/util/HexColor.dart';
import 'package:yeni_okul/util/SharedPrefHelper.dart';
import '../../util/YOColors.dart';
import '../../widgets/CourseListItem.dart';
import '../../widgets/QuickAction.dart';
import '../company/model/CompanyModel.dart';
import '../course/model/CourseModel.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  CarouselController buttonCarouselController = CarouselController();
  List<QuickActionModel> quickActionList = [
    QuickActionModel(name: "Ders Programı", icon: "assets/teacher_circle.png"),
    QuickActionModel(name: "Ders Bul", icon: "assets/teacher_circle.png"),
    QuickActionModel(name: "Kurum Bul", icon: "assets/teacher_circle.png"),
    QuickActionModel(name: "Ders Talep Et", icon: "assets/teacher_circle.png"),
    QuickActionModel(name: "Eğitim Koçu", icon: "assets/teacher_circle.png"),
    QuickActionModel(name: "Deneme Kulubü", icon: "assets/teacher_circle.png"),
  ];
  late HomePageViewModel viewModel;
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
  late Future<String?> userNameFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the future to read user name
    userNameFuture = readData("user_name");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<String?>(
          future: userNameFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final userName = snapshot.data;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      height: 200.0,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: false,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.2,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: [1, 2, 3, 4, 5].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'text $i',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16),
                    child: Text(
                      "Kolay İşlemler",
                      style: styleBlack16Bold,
                    ),
                  ),
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: quickActionList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        if (index == 2) {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed("/companyList");
                        }
                        if (index == 0) {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed("/timeSheetPage");
                        }
                        if (index == 3) {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed("/requestLessonPage");
                        }
                      },
                      child: QuickAction(
                        icon: quickActionList[index].icon,
                        name: quickActionList[index].name,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor("#F6F6F6"),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (userName != null) ...[
                                  Text(
                                    userName,
                                    style: styleBlack14Bold,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Text(
                                      "Kuruma ait dersleri Görüntüle",
                                      style: styleBlack12Regular,
                                    ),
                                  )
                                ] else ...[
                                  Text(
                                    'Kullanıcı adı mevcut değil',
                                    style: styleBlack14Bold,
                                  ),
                                ]
                              ],
                            ),
                            const Icon(Icons.arrow_circle_right_outlined)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8, left: 16),
                    child: Text(
                      "İlgilenecebileceğin Dersler",
                      style: styleBlack16Bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 4.5,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.96,
                            child: const CourseListItem(),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
