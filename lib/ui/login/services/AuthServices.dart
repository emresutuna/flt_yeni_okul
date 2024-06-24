import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yeni_okul/ui/login/model/UserRegisterModel.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// create user
  Future<UserRegisterModel?> signUpUser(
    UserRegisterModel userRegisterModel,
  ) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: userRegisterModel.email.trim(),
        password: userRegisterModel.password.trim(),
      );
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        userRegisterModel.id = firebaseUser.uid;
        addUserDb(userRegisterModel);
        return UserRegisterModel(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            name: firebaseUser.displayName ?? '',
            surname: userRegisterModel.surname,
            phone: userRegisterModel.phone,
            password: "****",
            userRole: userRegisterModel.userRole,
            createdDate: DateTime.timestamp(),
            companyCode: userRegisterModel.companyCode ?? 0);
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<void> addUserDb(UserRegisterModel userRegisterModel) async {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    usersCollection.add(userRegisterModel.toJson());
  }

  ///signOutUser
  Future<void> signOutUser() async {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }

  Future<dynamic> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }
}
