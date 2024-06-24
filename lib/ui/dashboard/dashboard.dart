import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:yeni_okul/ui/HomePageViewModel.dart';
import 'package:yeni_okul/ui/model/QuickActionModel.dart';
import '../../util/YOColors.dart';
import '../../widgets/QuickAction.dart';
import '../../widgets/YOText.dart';
import '../../widgets/YellowBox.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  CarouselController buttonCarouselController = CarouselController();
  int _current = 1;
  List<QuickActionModel> quickActionList = [
    QuickActionModel(name: "Ders Programı", icon: "assets/teacher_circle.png"),
    QuickActionModel(
        name: "Satın Aldığım Dersler", icon: "assets/teacher_circle.png"),
    QuickActionModel(name: "Kurumlar", icon: "assets/teacher_circle.png"),
  ];
  late HomePageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Container(
                  decoration: gradient,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 90.0),
                          child: CarouselSlider(
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
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.amberAccent,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        'text $i',
                                        style: const TextStyle(fontSize: 16.0),
                                      ));
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [1, 2, 3, 4, 5].map((entry) {
                            return GestureDetector(
                              onTap: () {
                                buttonCarouselController.animateToPage(entry);
                                _current = entry;
                              },
                              child: Container(
                                width: 12.0,
                                height: 12.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black)
                                        .withOpacity(
                                            _current == entry ? 0.9 : 0.4)),
                              ),
                            );
                          }).toList(),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: YellowCard(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        YoText(text: "Merhaba Tamer"),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: YoText(
                                              text:
                                                  "Lorem ipsum dolar sit amet,Lorem ipsum dolar sit ametLorem ipsum dolar sit amet"),
                                        )
                                      ],
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(right: 16.0),
                                child: Center(
                                  child:
                                      Icon(Icons.arrow_circle_right_outlined),
                                ),
                              )
                            ],
                          )),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: YellowCard(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        YoText(text: "Merhaba Tamer"),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: YoText(
                                              text:
                                                  "Lorem ipsum dolar sit amet,Lorem ipsum dolar sit ametLorem ipsum dolar sit amet"),
                                        )
                                      ],
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(right: 16.0),
                                child: Center(
                                  child:
                                      Icon(Icons.arrow_circle_right_outlined),
                                ),
                              )
                            ],
                          )),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0, left: 16),
                          child: YoText(
                            text: "Kolay İşlemler",
                            size: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          height: 120,
                          child: GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: quickActionList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10,
                                crossAxisCount: 3,
                                crossAxisSpacing: 3,
                              ),
                              itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      if(index == 2){
                                        Navigator.pushNamed(context, '/companyList');
                                      }
                                    },
                                    child: QuickAction(
                                        icon: quickActionList[index].icon,
                                        name: quickActionList[index].name),
                                  )),
                        )
                      ])),
            );
          }),
    );
  }
}
