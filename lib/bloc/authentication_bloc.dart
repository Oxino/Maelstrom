import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maelstrom/bloc/firestore_bloc.dart';
import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/business_model.dart';
import 'package:maelstrom/models/user_model.dart';
import 'dart:async';

import 'package:maelstrom/widgets/base_text.dart';

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
    required Timestamp birthDate,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      curentUser = UserModel(
          id: authResult.user!.uid,
          email: email,
          firstName: firstName,
          lastName: lastName,
          birthDate: birthDate,
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

      curentUser = BusinessModel(
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

      return '';
    } on FirebaseException catch (e) {
      print(e);
      return e.message;

      // Utils.showSnackBar(e.message);
    }
  }
}
