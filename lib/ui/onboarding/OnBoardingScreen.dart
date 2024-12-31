import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/YOColors.dart';
import 'package:baykurs/widgets/IconButton.dart';
import 'package:baykurs/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;


  final List<Map<String, String>> onboardingData = [
    {
      'title': 'En İyisini Yakala!',
      'description':
      'Sadece ders satın alarak hiçbir kuruma bağlı kalma, en iyi dersi sana en uygun kurumdan alarak başarıyı yakala!',
      'imageAsset': 'assets/first_slide.jpg',
    },
    {
      'title': 'Yüz Yüze Eğitimin Özgün Modeli',
      'description':
      'Başarıya ulaşmak için eksiklerini belirle ve sadece ihtiyacın olan derslerle sınava hazırlanarak yüz yüze eğitimin özgün modeliyle tanış!',
      'imageAsset': 'assets/second_slide_alternative.jpg',
    },
    {
      'title': 'İyi Eğitim İyi Hocayla Alınır',
      'description':
      'Dersini satın aldığın kurum ya da öğretmeni beğenmediysen sonraki dersi başka kurum ya da başka öğretmenden alarak sevimsiz eğitim yılı geçirmekten kurtul!',
      'imageAsset': 'assets/third_slide.jpg',
    },
  ];

  void _skipToLastPage() {
    _pageController.jumpToPage(onboardingData.length - 1);
  }

  void _goToNextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      _goToLoginPage();
    }
  }

  void _goToLoginPage() {
    Navigator.pushReplacementNamed(context, '/guestPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightGray,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) => OnboardingPage(
                title: onboardingData[index]['title']!,
                description: onboardingData[index]['description']!,
                imageAsset: onboardingData[index]['imageAsset']!,
                isLastPage: index == onboardingData.length - 1,
              ),
            ),
          ),
          _currentPage == onboardingData.length - 1
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          text: 'Devam Et',
                          onPress: _goToNextPage,
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _skipToLastPage,
                        child: Text('Geç', style: styleBlack16Regular),
                      ),
                      BkIconButton(
                          onPressed: _goToNextPage,
                          iconData: Icons.arrow_forward_rounded),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final bool isLastPage;
  final String imageAsset;


  const OnboardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.isLastPage,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
              color: Color(0xFFB3E5FC),
            ),
            child: Center(
              child:  Image.asset(
                imageAsset,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.5,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorLightGray,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  16.toHeight,
                  Text(title,
                      textAlign: TextAlign.center, style: styleBlack22Bold),
                  16.toHeight,
                  Text(description,
                      textAlign: TextAlign.center,
                      style: style54Black14Regular),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
