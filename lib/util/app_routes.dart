import 'package:baykurs/ui/coursedetail/bloc/CourseDetailBloc.dart';
import 'package:baykurs/ui/payment/PaymentPreviewPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../main.dart';
import '../repository/SchoolRepository.dart';
import '../repository/lectureRepository.dart';
import '../repository/userRepository.dart';
import '../ui/company/CompanyListPage.dart';
import '../ui/company/bloc/SchoolBloc.dart';
import '../ui/companyDetail/CompanyDetailPage.dart';
import '../ui/companyDetail/bloc/SchoolDetailBloc.dart';
import '../ui/course/CourseListPage.dart';
import '../ui/course/bloc/LessonBloc.dart';
import '../ui/coursedetail/CourseDetailPage.dart';
import '../ui/forgotpassword/forgotPasswordEmail.dart';
import '../ui/login/emailOtpPage.dart';
import '../ui/login/loginBloc/LoginBloc.dart';
import '../ui/login/loginPage.dart';
import '../ui/login/newPasswordPage.dart';
import '../ui/onboarding/onboarding.dart';
import '../ui/payment/PaymentResultPage.dart';
import '../ui/purchasehistory/PurchaseHistoryPage.dart';
import '../ui/register/registerPage.dart';
import '../ui/requestlesson/RequestLessonPage.dart';
import '../ui/timesheet/TimeSheetPage.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
        '/onboardingPage': (context) => const OnboardingPage(),
        '/mainPage': (context) => const MyHomePage(title: ""),
        '/registerPage': (context) => const RegisterPage(),
        '/forgotPasswordEmail': (context) => const ForgotPasswordEmailPage(),
        '/emailOtp': (context) => const EmailOtpPage(),
        '/newPasswordPage': (context) => const NewPasswordPage(),
        '/companyDetail': (context) => BlocProvider(
              create: (context) =>
                  SchoolDetailBloc(schoolRepository: SchoolRepository()),
              child: const CompanyDetailPage(),
            ),
        '/courseListPage': (context) => BlocProvider(
              create: (context) =>
                  LessonBloc(lectureRepository: LectureRepository()),
              child: const CourseListPage(),
            ),
    '/courseDetail': (context) => BlocProvider(
      create: (context) =>
          CourseDetailBloc(lectureRepository: LectureRepository()),
      child: const CourseDetailPage(),
    ),
        '/companyList': (context) => BlocProvider(
              create: (context) =>
                  SchoolBloc(schoolRepository: SchoolRepository()),
              child: const CompanyListPage(),
            ),
        '/paymentResultPage': (context) => const PaymentResultPage(),
        '/paymentPreview': (context) => const PaymentPreviewPage(),
        '/timeSheetPage': (context) => const TimeSheetPage(),
        '/purchaseHistoryPage': (context) => const PurchaseHistoryPage(),
        '/requestLessonPage': (context) =>  RequestLessonPage(),
        '/loginPage': (context) => BlocProvider(
              create: (context) => LoginBloc(userRepository: UserRepository()),
              child: const LoginPage(),
            ),
      };
}
