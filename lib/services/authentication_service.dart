import 'package:firebase_auth/firebase_auth.dart';
import 'package:maelstrom/models/business.dart';
import 'package:maelstrom/services/firestoreService.dart';
import 'package:maelstrom/models/curent_user.dart';
import 'dart:async';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  bool isEmailVerified = false;
  bool isBusinessUser = false;
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

      isBusinessUser = false;

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

  Future signUpBusinessWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String institutionName,
    required String siret,
    required String address,
    required String description,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      curentUser = Business(
          id: authResult.user!.uid,
          institutionName: institutionName,
          siret: siret,
          address: address,
          description: description,
          firstName: firstName,
          lastName: lastName,
          email: email);

      isBusinessUser = true;

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
    isBusinessUser
        ? await _firestoreService.createBusinessUser(curentUser)
        : await _firestoreService.createUser(curentUser);
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

  Future signIn(isBusiness, email, value) async {
    isBusinessUser = isBusiness;
    try {
      var authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: value,
      );
      curentUser = _firestoreService.getUser(isBusiness, authResult.user!.uid);
    } on FirebaseException catch (e) {
      print(e);

      // Utils.showSnackBar(e.message);
    }
  }
}
