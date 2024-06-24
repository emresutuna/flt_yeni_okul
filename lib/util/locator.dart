import 'package:get_it/get_it.dart';

import '../repository/Repository.dart';
import '../service/FirebaseAuthService.dart';
import '../service/FirestoreService.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => FireStoreService());
  getIt.registerLazySingleton(() => FirebaseAuthService());
  getIt.registerLazySingleton(() => Repository());
}