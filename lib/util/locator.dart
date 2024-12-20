import 'package:get_it/get_it.dart';


import '../repository/Repository.dart';
import '../repository/SchoolRepository.dart';
import '../repository/lectureRepository.dart';
import '../service/FirebaseAuthService.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => FirebaseAuthService());
  getIt.registerLazySingleton(() => Repository());
  getIt.registerLazySingleton(() => LectureRepository());
  getIt.registerLazySingleton(() => SchoolRepository());
}