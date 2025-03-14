import 'package:baykurs/repository/payment_repository.dart';
import 'package:baykurs/ui/courseBundle/course_bundle.dart';
import 'package:baykurs/ui/courseBundleDetail/course_bundle_detail.dart';
import 'package:baykurs/ui/coursedetail/bloc/course_detail_bloc.dart';
import 'package:baykurs/ui/favoriteschool/bloc/favorite_school_bloc.dart';
import 'package:baykurs/ui/forgotpassword/bloc/ForgotPasswordBloc.dart';
import 'package:baykurs/ui/notification/bloc/NotificationBloc.dart';
import 'package:baykurs/ui/onboarding/GuestPage.dart';
import 'package:baykurs/ui/payment/PaymentPreviewPage.dart';
import 'package:baykurs/ui/payment/bloc/PaymentPreviewBloc.dart';
import 'package:baykurs/ui/payment/makePayment/MakePaymentPage.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/PaymentBillList.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/billListBloc/BillListBloc.dart';
import 'package:baykurs/ui/profile/UserEditSelection.dart';
import 'package:baykurs/ui/profile/bloc/EducationInformationBloc.dart';
import 'package:baykurs/ui/profile/bloc/PasswordUpdateBloc.dart';
import 'package:baykurs/ui/profile/educationInformation/EducationInformationPage.dart';
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
import '../repository/school_repository.dart';
import '../repository/lecture_repository.dart';
import '../repository/user_repository.dart';
import '../ui/company/company_list_page.dart';
import '../ui/company/bloc/school_bloc.dart';
import '../ui/companyDetail/company_detail_page.dart';
import '../ui/companyDetail/bloc/school_detail_bloc.dart';
import '../ui/course/course_list_page.dart';
import '../ui/course/bloc/lesson_bloc.dart';
import '../ui/coursedetail/course_detail_page.dart';
import '../ui/favoriteschool/favorite_school_page.dart';
import '../ui/forgotpassword/forgotPasswordEmail.dart';
import '../ui/login/loginBloc/login_bloc.dart';
import '../ui/login/loginPage.dart';
import '../ui/notification/NotificationPage.dart';
import '../ui/onboarding/OnBoardingScreen.dart';
import '../ui/paymentHistory/PaymentHistoryPage.dart';
import '../ui/profile/userEdit/PhoneUpdatePage.dart';
import '../ui/purchasehistory/PurchaseHistoryPage.dart';
import '../ui/register/registerPage.dart';
import '../ui/requestlesson/RequestLessonPage.dart';
import '../ui/timesheet/TimeSheetPage.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
        '/onboardingPage': (context) => const OnboardingScreen(),
        '/paymentHistoryPage': (context) => const PaymentHistoryPage(),
        '/teacherCoach': (context) => const TeacherCoach(),
        '/notificationPage': (context) => BlocProvider(
              create: (context) =>
                  NotificationBloc(userRepository: UserRepository()),
              child: const NotificationPage(),
            ),
        '/favoriteSchool': (context) => BlocProvider(
              create: (context) =>
                  FavoriteSchoolBloc(userRepository: UserRepository()),
              child: const FavoriteSchoolPage(),
            ),
        '/mainPage': (context) => const MyHomePage(title: ""),
        '/emailActivationInfoPage': (context) =>
            const EmailActivationInfoPage(),
        '/guestPage': (context) => const GuestPage(),
        '/forgotPasswordEmail': (context) => BlocProvider(
              create: (context) =>
                  ForgotPasswordBloc(userRepository: UserRepository()),
              child: const ForgotPasswordEmailPage(),
            ),
        '/educationInformationPage': (context) => BlocProvider(
              create: (context) =>
                  EducationInformationBloc(userRepository: UserRepository()),
              child: const EducationInformationPage(),
            ),
        '/userEditSelection': (context) => const UserEditSelection(),
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
        '/phoneUpdate': (context) => BlocProvider(
              create: (context) =>
                  PasswordUpdateBloc(userRepository: UserRepository()),
              child: const PhoneUpdatePage(),
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
        '/makePayment': (context) => BlocProvider(
              create: (context) =>
                  PaymentPreviewBloc(paymentRepository: PaymentRepository()),
              child: const MakePaymentPage(),
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
              child: const LoginPage(
                showClose: false,
              ),
            ),
        '/registerPage': (context) => BlocProvider(
              create: (context) =>
                  RegisterBloc(userRepository: UserRepository()),
              child: const RegisterPage(),
            ),
        '/billList': (context) => BlocProvider(
              create: (context) =>
                  BillListBloc(userRepository: UserRepository()),
              child: const PaymentBillList(),
            ),
      };
}
