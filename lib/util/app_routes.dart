import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yeni_okul/repository/SchoolRepository.dart';
import 'package:yeni_okul/repository/userRepository.dart';
import 'package:yeni_okul/ui/companyDetail/CompanyDetailPage.dart';
import 'package:yeni_okul/ui/company/CompanyListPage.dart';
import 'package:yeni_okul/ui/company/bloc/SchoolBloc.dart';
import 'package:yeni_okul/ui/companyDetail/bloc/SchoolDetailBloc.dart';
import 'package:yeni_okul/ui/course/CourseListPage.dart';
import 'package:yeni_okul/ui/forgotpassword/forgotPasswordEmail.dart';
import 'package:yeni_okul/ui/login/emailOtpPage.dart';
import 'package:yeni_okul/ui/login/loginBloc/LoginBloc.dart';
import 'package:yeni_okul/ui/login/loginPage.dart';
import 'package:yeni_okul/ui/login/newPasswordPage.dart';
import 'package:yeni_okul/ui/onboarding/onboarding.dart';
import 'package:yeni_okul/ui/payment/PaymentPage.dart';
import 'package:yeni_okul/ui/purchasehistory/PurchaseHistoryPage.dart';
import 'package:yeni_okul/ui/register/registerPage.dart';
import 'package:yeni_okul/ui/register/userRolePage.dart';
import 'package:yeni_okul/ui/requestlesson/RequestLessonPage.dart';
import 'package:yeni_okul/ui/timesheet/TimeSheetPage.dart';

import '../main.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
    '/onboardingPage': (context) => const OnboardingPage(),
    '/mainPage': (context) => const MyHomePage(title: ""),
    '/userRolePage': (context) => const UserRolePage(),
    '/registerPage': (context) => const RegisterPage(),
    '/forgotPasswordEmail': (context) => const ForgotPasswordEmailPage(),
    '/emailOtp': (context) => const EmailOtpPage(),
    '/newPasswordPage': (context) => const NewPasswordPage(),
    '/companyDetail': (context) => BlocProvider(
      create: (context) => SchoolDetailBloc(schoolRepository: SchoolRepository()),
      child: const CompanyDetailPage(),
    ),
    '/courseListPage': (context) => const CourseListPage(),
    '/companyList': (context) => BlocProvider(
      create: (context) => SchoolBloc(schoolRepository: SchoolRepository()),
      child: const CompanyListPage(),
    ),
    '/paymentPage': (context) => const PaymentPage(),
    '/timeSheetPage': (context) => const TimeSheetPage(),
    '/purchaseHistoryPage': (context) => const PurchaseHistoryPage(),
    '/requestLessonPage': (context) => const RequestLessonPage(),
    '/loginPage': (context) => BlocProvider(
      create: (context) => LoginBloc(userRepository: UserRepository()),
      child: const LoginPage(),
    ),
  };
}
