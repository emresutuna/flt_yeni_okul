import 'package:baykurs/repository/SchoolRepository.dart';
import 'package:baykurs/repository/userRepository.dart';
import 'package:baykurs/ui/company/bloc/SchoolBloc.dart';
import 'package:baykurs/ui/companyDetail/bloc/SchoolDetailBloc.dart';
import 'package:baykurs/ui/dashboard/dashboard.dart';
import 'package:baykurs/ui/login/loginBloc/LoginBloc.dart';
import 'package:baykurs/ui/profile/bloc/ProfileBloc.dart';
import 'package:baykurs/ui/profile/profile.dart';
import 'package:baykurs/util/SharedPref.dart';
import 'package:baykurs/util/SharedPrefHelper.dart';
import 'package:baykurs/util/YOColors.dart';
import 'package:baykurs/util/app_routes.dart';
import 'package:baykurs/util/constants.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';


SharedPreferences? sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PreferenceUtils.init();
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
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? initialRoute;

  @override
  void initState() {
    super.initState();
    saveToken("3|qbnDaTS6ZN3aObipML6qq8ZE9WyhlPlKqfUn7HvT235efa9c");

    _checkOnboardingAndToken();

  }

  Future<void> _checkOnboardingAndToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    String userToken = prefs.getString('auth_token') ?? "";

    if (isFirstTime) {
      setState(() {
        initialRoute = '/onboardingPage';
      });
      prefs.setBool('isFirstTime', false);
    } else if (userToken.isEmpty) {
      setState(() {
        initialRoute = '/loginPage';
      });
    } else {
      setState(() {
        initialRoute = '/mainPage';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (initialRoute == null) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return GetMaterialApp(
      navigatorObservers: [ChuckerFlutter.navigatorObserver],
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      routes: AppRoutes.routes,
    );
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
    const DashboardPage(),
    const Placeholder(),
    const ProfilePage()
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
        title: (AppStrings.homeTitle),
        activeColorPrimary: color5,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: (AppStrings.searchTitle),
        activeColorPrimary: color5,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: (AppStrings.profileTitle),
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
