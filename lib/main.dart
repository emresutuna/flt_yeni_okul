import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeni_okul/ui/company/CompanyDetailPage.dart';
import 'package:yeni_okul/ui/company/CompanyListPage.dart';
import 'package:yeni_okul/ui/course/CourseListPage.dart';
import 'package:yeni_okul/ui/dashboard/dashboard.dart';
import 'package:yeni_okul/ui/forgotpassword/forgotPasswordEmail.dart';
import 'package:yeni_okul/ui/login/UserRole.dart';
import 'package:yeni_okul/ui/login/emailOtpPage.dart';
import 'package:yeni_okul/ui/login/loginPage.dart';
import 'package:yeni_okul/ui/login/newPasswordPage.dart';
import 'package:yeni_okul/ui/onboarding/onboarding.dart';
import 'package:yeni_okul/ui/payment/PaymentPage.dart';
import 'package:yeni_okul/ui/profile.dart';
import 'package:yeni_okul/ui/register/registerPage.dart';
import 'package:yeni_okul/ui/register/userRolePage.dart';
import 'package:yeni_okul/util/SharedPref.dart';
import 'package:yeni_okul/widgets/YOAppBar.dart';

SharedPreferences? sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PreferenceUtils.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String uiid = PreferenceUtils.getString("user");

    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: uiid.isEmpty ? "/onboardingPage" : "/mainPage",
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/onboardingPage': (context) => const OnboardingPage(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/mainPage': (context) => const MyHomePage(title: ""),
          '/loginPage': (context) => const LoginPage(),
          '/userRolePage': (context) => const UserRolePage(),
          '/registerPage': (context) => const RegisterPage(
                userRole: UserRole.DEFAULT,
              ),
          '/forgotPasswordEmail': (context) => const ForgotPasswordEmailPage(),
          '/emailOtp': (context) => const EmailOtpPage(),
          '/newPasswordPage': (context) => const NewPasswordPage(),
          '/companyList': (context) => const CompanyListPage(),
          '/companyDetail': (context) => const CompanyDetailPage(),
          '/courseListPage': (context) => const CourseListPage(),
          '/paymentPage': (context) => const PaymentPage()
        },
        home: const LoginPage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> listWidget = const [
    DashboardPage(),
    Placeholder(),
    ProfilePage()
  ];
  int bottomSelectedIndex = 0;

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      const BottomNavigationBarItem(
          icon: Icon(Icons.home_filled), label: "Anasayfa"),
      const BottomNavigationBarItem(
        icon: Icon(Icons.favorite_outlined),
        label: "Favoriler",
      ),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil")
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView.builder(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      itemCount: listWidget.length,
      itemBuilder: (BuildContext context, int index) {
        return listWidget[index];
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> key = GlobalKey();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: YOAppBar(
        enableBackButton: false,
        drawerKey: key,
      ),
      body: buildPageView(),
      bottomNavigationBar: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 5,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 20,
          currentIndex: bottomSelectedIndex,
          onTap: (index) {
            bottomTapped(index);
          },
          items: buildBottomNavBarItems(),
        ),
      ),
    );
  }
}
