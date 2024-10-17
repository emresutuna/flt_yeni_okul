import 'package:get_it/get_it.dart';
import 'package:yeni_okul/repository/SchoolRepository.dart';
import 'package:yeni_okul/repository/lectureRepository.dart';

import '../repository/Repository.dart';
import '../service/FirebaseAuthService.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => FirebaseAuthService());
  getIt.registerLazySingleton(() => Repository());
  getIt.registerLazySingleton(() => LectureRepository());
  getIt.registerLazySingleton(() => SchoolRepository());
}