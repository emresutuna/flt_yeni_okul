import 'package:firebase_auth/firebase_auth.dart';
import 'package:yeni_okul/util/state.dart';

class FirebaseAuthService {
  final firebaseAuthService = FirebaseAuth.instance;

  Future registerWithMail(String email, String password) async {
    try {
      UserCredential _userCredential = await firebaseAuthService.createUserWithEmailAndPassword(email: email, password: password);

      if (_userCredential.user != null) {
        return _userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      print("Auth exception ${e.toString()}");
    }
  }

  Future<bool> loginWithMail(String email, String password) async {
    var state = State.LOADING;
    try {
      await firebaseAuthService.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("Auth exception ${e.toString()}");
      state = State.ERROR;
    }
    return true;
  }
}