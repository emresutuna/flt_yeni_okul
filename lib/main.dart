import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeni_okul/repository/SchoolRepository.dart';
import 'package:yeni_okul/repository/userRepository.dart';
import 'package:yeni_okul/ui/companyDetail/CompanyDetailPage.dart';
import 'package:yeni_okul/ui/company/CompanyListPage.dart';
import 'package:yeni_okul/ui/company/bloc/SchoolBloc.dart';
import 'package:yeni_okul/ui/companyDetail/bloc/SchoolDetailBloc.dart';
import 'package:yeni_okul/ui/course/CourseListPage.dart';
import 'package:yeni_okul/ui/dashboard/dashboard.dart';
import 'package:yeni_okul/ui/forgotpassword/forgotPasswordEmail.dart';
import 'package:yeni_okul/ui/login/emailOtpPage.dart';
import 'package:yeni_okul/ui/login/loginBloc/LoginBloc.dart';
import 'package:yeni_okul/ui/login/loginPage.dart';
import 'package:yeni_okul/ui/login/newPasswordPage.dart';
import 'package:yeni_okul/ui/onboarding/onboarding.dart';
import 'package:yeni_okul/ui/payment/PaymentPage.dart';
import 'package:yeni_okul/ui/profile/bloc/ProfileBloc.dart';
import 'package:yeni_okul/ui/profile/profile.dart';
import 'package:yeni_okul/ui/purchasehistory/PurchaseHistoryPage.dart';
import 'package:yeni_okul/ui/register/registerPage.dart';
import 'package:yeni_okul/ui/register/userRolePage.dart';
import 'package:yeni_okul/ui/requestlesson/RequestLessonPage.dart';
import 'package:yeni_okul/ui/timesheet/TimeSheetPage.dart';
import 'package:yeni_okul/util/SharedPref.dart';
import 'package:yeni_okul/util/YOColors.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

SharedPreferences? sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PreferenceUtils.init();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(userRepository: UserRepository()),
        ),
        BlocProvider(
          create: (context) => SchoolBloc(schoolRepository: SchoolRepository()),
        ),
        BlocProvider(
          create: (context) =>
              SchoolDetailBloc(schoolRepository: SchoolRepository()),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(userRepository: UserRepository()),
        ),
        // Add other BlocProviders as needed
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String userToken = PreferenceUtils.getString("auth_token");

    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: userToken.isEmpty ? "/loginPage" : "/mainPage",
        routes: {
          '/onboardingPage': (context) => const OnboardingPage(),
          '/mainPage': (context) => const MyHomePage(title: ""),
          '/userRolePage': (context) => const UserRolePage(),
          '/registerPage': (context) => const RegisterPage(),
          '/forgotPasswordEmail': (context) => const ForgotPasswordEmailPage(),
          '/emailOtp': (context) => const EmailOtpPage(),
          '/newPasswordPage': (context) => const NewPasswordPage(),
          '/companyDetail': (context) => BlocProvider(
                create: (context) =>
                    SchoolDetailBloc(schoolRepository: SchoolRepository()),
                child: CompanyDetailPage(),
              ),
          '/courseListPage': (context) => const CourseListPage(),
          '/companyList': (context) => BlocProvider(
                create: (context) =>
                    SchoolBloc(schoolRepository: SchoolRepository()),
                child: CompanyListPage(),
              ),
          '/paymentPage': (context) => const PaymentPage(),
          '/timeSheetPage': (context) => const TimeSheetPage(),
          '/purchaseHistoryPage': (context) => const PurchaseHistoryPage(),
          '/requestLessonPage': (context) => const RequestLessonPage(),
          '/loginPage': (context) => BlocProvider(
                create: (context) =>
                    LoginBloc(userRepository: UserRepository()),
                child: LoginPage(),
              ),
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
  List<Widget> listWidget = [
    DashboardPage(),
    Placeholder(),
    ProfilePage()
  ];

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [const DashboardPage(), const Placeholder(), const ProfilePage()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: color5,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: ("Search"),
        activeColorPrimary: color5,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: color5,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarHeight: 60,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }
}
