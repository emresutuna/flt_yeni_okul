import 'package:baykurs/repository/paymentReposityory.dart';
import 'package:baykurs/ui/courseBundle/CourseBundle.dart';
import 'package:baykurs/ui/courseBundleDetail/CourseBundleDetail.dart';
import 'package:baykurs/ui/coursedetail/bloc/CourseDetailBloc.dart';
import 'package:baykurs/ui/favoriteschool/bloc/FavoriteSchoolBloc.dart';
import 'package:baykurs/ui/onboarding/GuestPage.dart';
import 'package:baykurs/ui/payment/PaymentPreviewPage.dart';
import 'package:baykurs/ui/payment/bloc/PaymentPreviewBloc.dart';
import 'package:baykurs/ui/profile/UserEditSelection.dart';
import 'package:baykurs/ui/profile/bloc/PasswordUpdateBloc.dart';
import 'package:baykurs/ui/profile/passwordUpdate/PasswordUpdatePage.dart';
import 'package:baykurs/ui/profile/userEdit/MailUpdatePage.dart';
import 'package:baykurs/ui/register/EmailActivationInfoPage.dart';
import 'package:baykurs/ui/register/bloc/RegisterBloc.dart';
import 'package:baykurs/ui/requestlesson/bloc/RequestLessonBloc.dart';
import 'package:baykurs/ui/teacherCoach/TeacherCoach.dart';
import 'package:baykurs/ui/teacherCoachDetail/TeacherCoachDetail.dart';
import 'package:baykurs/ui/timesheet/bloc/TimeSheetBloc.dart';
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
import '../ui/favoriteschool/FavoriteSchoolPage.dart';
import '../ui/forgotpassword/forgotPasswordEmail.dart';
import '../ui/login/emailOtpPage.dart';
import '../ui/login/loginBloc/LoginBloc.dart';
import '../ui/login/loginPage.dart';
import '../ui/login/newPasswordPage.dart';
import '../ui/notification/NotificationPage.dart';
import '../ui/onboarding/OnBoardingScreen.dart';
import '../ui/purchasehistory/PurchaseHistoryPage.dart';
import '../ui/register/registerPage.dart';
import '../ui/requestlesson/RequestLessonPage.dart';
import '../ui/timesheet/TimeSheetPage.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
        '/onboardingPage': (context) =>  OnboardingScreen(),
        '/teacherCoach': (context) => const TeacherCoach(),
        '/notificationPage': (context) => BlocProvider(
              create: (context) =>
                  FavoriteSchoolBloc(userRepository: UserRepository()),
              child:  const NotificationPage(),
            ),
        '/favoriteSchool': (context) => BlocProvider(
              create: (context) =>
                  FavoriteSchoolBloc(userRepository: UserRepository()),
              child: const FavoriteSchoolPage(),
            ),
        '/mainPage': (context) => const MyHomePage(title: ""),
        '/emailActivationInfoPage': (context) => const EmailActivationInfoPage(),
        '/guestPage': (context) => const GuestPage(),
        '/forgotPasswordEmail': (context) => const ForgotPasswordEmailPage(),
        '/emailOtp': (context) => const EmailOtpPage(),
        '/userEditSelection': (context) => const UserEditSelection(),
        '/newPasswordPage': (context) => const NewPasswordPage(),
        '/companyDetail': (context) => BlocProvider(
              create: (context) =>
                  SchoolDetailBloc(schoolRepository: SchoolRepository()),
              child: const CompanyDetailPage(),
            ),
        '/passwordUpdate': (context) => BlocProvider(
              create: (context) =>
                  PasswordUpdateBloc(userRepository: UserRepository()),
              child: const PasswordUpdatePage(),
            ),
        '/mailUpdate': (context) => BlocProvider(
              create: (context) =>
                  PasswordUpdateBloc(userRepository: UserRepository()),
              child: const MailUpdatePage(),
            ),
        '/courseListPage': (context) => BlocProvider(
              create: (context) =>
                  LessonBloc(lectureRepository: LectureRepository()),
              child: const CourseListPage(
                hasShowBackButton: true,
              ),
            ),
        '/courseBundleList': (context) => BlocProvider(
              create: (context) =>
                  LessonBloc(lectureRepository: LectureRepository()),
              child: const CourseBundleListPage(),
            ),
        '/courseDetail': (context) => BlocProvider(
              create: (context) =>
                  CourseDetailBloc(lectureRepository: LectureRepository()),
              child: const CourseDetailPage(),
            ),
        '/courseBundleDetail': (context) => BlocProvider(
              create: (context) =>
                  CourseDetailBloc(lectureRepository: LectureRepository()),
              child: const CourseBundleDetailPage(),
            ),
        '/teacherCoachDetail': (context) => BlocProvider(
              create: (context) =>
                  CourseDetailBloc(lectureRepository: LectureRepository()),
              child: const TeacherCoachDetail(),
            ),
        '/companyList': (context) => BlocProvider(
              create: (context) =>
                  SchoolBloc(schoolRepository: SchoolRepository()),
              child: const CompanyListPage(),
            ),
        '/paymentPreview': (context) => BlocProvider(
              create: (context) =>
                  PaymentPreviewBloc(paymentRepository: PaymentRepository()),
              child: const PaymentPreviewPage(),
            ),
        '/timeSheetPage': (context) => BlocProvider(
              create: (context) =>
                  TimeSheetBloc(userRepository: UserRepository()),
              child: const TimeSheetPage(),
            ),
        '/purchaseHistoryPage': (context) => const PurchaseHistoryPage(),
        '/requestLessonPage': (context) => BlocProvider(
              create: (context) =>
                  RequestLessonBloc(userRepository: UserRepository()),
              child: const RequestLessonPage(),
            ),
        '/loginPage': (context) => BlocProvider(
              create: (context) => LoginBloc(userRepository: UserRepository()),
              child: const LoginPage(),
            ),
        '/registerPage': (context) => BlocProvider(
              create: (context) =>
                  RegisterBloc(userRepository: UserRepository()),
              child: const RegisterPage(),
            ),
      };
}
