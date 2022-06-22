import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

abstract class BaseAuth {
  Future<User> currentUser();
  Future<User> signIn(String email, String password);
  Future<User> createUser(String email, String password);
  Future<void> signOut();
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<void> updateEMail(String newEmail);
  Future<void> updatePhoto(String newUrlPhoto);
  Future<void> updateName(String name);
  Future<void> updatePassword(String newPassword);
  Future<void> sendVerificationEmail();
  Future<void> sendPasswordResetEmail(String email);
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserCredential? user;

  @override
  Future<User> signIn(String email, String password) async {
    UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user!;
  }

  @override
  Future<User> createUser(String email, String password) async {
    UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.user!;
  }

//Get a user's profile
  @override
  Future<User> currentUser() async {
    User? user = _firebaseAuth.currentUser;
    return user!;
  }

  @override
  Future<void> signOut() async {
    try {
      return _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
      }
      print(e.message);
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      user = await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }

    return user!.user!;
  }

  @override
  Future<User> signInWithFacebook() async {
    // Trigger the sign-in flow
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      user = await _firebaseAuth.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
      }
      print(e.message);
    }
    // Once signed in, return the UserCredential
    return user!.user!;
  }

  @override
  Future<void> updateEMail(String newEmail) async {
    try {
      User user = await currentUser();

      await user.updateEmail(newEmail);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  @override
  Future<void> updateName(String name) async {
    try {
      User user = await currentUser();

      await user.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  @override
  Future<void> updatePhoto(String photoUrl) async {
    try {
      User user = await currentUser();

      await user.updatePhotoURL(photoUrl);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      User user = await currentUser();
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  @override
  Future<void> sendVerificationEmail() async {
    try {
      User user = await currentUser();
      await user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }
}
