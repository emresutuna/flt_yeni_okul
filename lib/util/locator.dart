import 'package:get_it/get_it.dart';
import '../repository/school_repository.dart';
import '../repository/lecture_repository.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {

  getIt.registerLazySingleton(() => LectureRepository());
  getIt.registerLazySingleton(() => SchoolRepository());
}