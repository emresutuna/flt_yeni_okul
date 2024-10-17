import '../service/FirebaseAuthService.dart';
import '../util/locator.dart';

class Repository {
  final FirebaseAuthService _firebaseAuthService = getIt<FirebaseAuthService>();

  Future registerWithMail(String email, String password) async {
    var result = await _firebaseAuthService!.registerWithMail(email, password);
    return result;
  }

  Future loginWithMail(String email, String password) async {
    bool result = await _firebaseAuthService!.loginWithMail(email, password);
    return result;
  }

  String getUserUid() {
    return _firebaseAuthService.firebaseAuthService.currentUser!.uid;
  }


}