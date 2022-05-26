import 'package:firebase_auth/firebase_auth.dart';
import 'package:maelstrom/services/firestoreService.dart';
import 'package:maelstrom/models/curent_user.dart';
import 'dart:async';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  bool isEmailVerified = false;
  Timer? timer;
  var curentUser;

  Future signUpWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      curentUser = CurentUser(
          id: authResult.user!.uid,
          email: email,
          firstName: firstName,
          lastName: lastName,
          favorite: []);

      return authResult.user != null;
    } on FirebaseException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        print('Le mot de passe est trop faible');
      } else if (e.code == 'email-already-in-use') {
        print('un compte existe déjà pour cet email');
      }
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = _firebaseAuth.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print(e);
      // Utils.showSnackBar(e.toString());
    }
  }

  Future createUserInFierstore() async {
    await _firestoreService.createUser(curentUser);
  }

  bool checkEmailVerified() {
    isEmailVerified = _firebaseAuth.currentUser!.emailVerified;

    if (isEmailVerified) {
      createUserInFierstore();

      return true;
    } else {
      return false;
    }
  }

  bool isInitEmailVerification() {
    //user needs to be created before!
    isEmailVerified = _firebaseAuth.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();
      return true;
    } else {
      return false;
    }
  }
}
