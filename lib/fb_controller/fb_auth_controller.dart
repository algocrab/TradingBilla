import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../shared-preferences/user_preferences_controler.dart';
import '../utils/helper.dart';
import 'firestore_controller.dart';

typedef UserAuthStates = void Function({required bool loggedIn});

class FbAuthController with Helpers {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> signIn(
      {required BuildContext context,
        required String email,
        required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          User? user = _firebaseAuth.currentUser;

          if (user != null) {
            await UserPreferenceController().saveUsers(
              email: email,
              name: password,
              users: await FbFireStoreController().readUser(
                id: user.uid.toString(),
              ),
            );
          }
          return true;
        } else {
          await signOut();
          showSnackBar(
              context: context,
              message: 'Verify email to login into the app!',
              error: true);
          return false;
        }
      }
      return false;
    } on FirebaseAuthException catch (e) {
      _controlException(context, e);
    } catch (e) {
      //
    }
    return false;
  }

  Future<bool> createAccount({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = _firebaseAuth.currentUser;
      final uid = user!.uid;
      // save user in firebase in collection users
      FirebaseFirestore.instance.collection('users').doc(uid).set(
        {
          'id': uid,
          'email': email,
          'name': name,
          'createAt': Timestamp.now(),
          'admin':false,
        },
      );

      userCredential.user?.sendEmailVerification();
      return true;
    } on FirebaseAuthException catch (e) {
      _controlException(context, e);
    } catch (e) {
      //
    }
    return false;
  }

  // //-------------- (Sign in using Google)------------------
  //
  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //   await googleUser?.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }
  //
  // //-------------- (Sign in using Facebook)------------------
  //
  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //   FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //
  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }

  //-------------(Sign Out)-------------------

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // -----------(return if user logged in or not)------------
  bool loggedIn() => _firebaseAuth.currentUser != null;

  // -----------(if you forget password ypu should use reset password)------------
  Future<bool> resetPassword(
      {required String email, required BuildContext context}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return true;
  }

  // ----------(some of type error in sign in & sign up)-----------
  void _controlException(
      BuildContext context, FirebaseAuthException exception) {
    showSnackBar(
        context: context,
        message: exception.message ?? 'ERROR !!',
        error: true);
    switch (exception.code) {
      case 'invalid-email':
        break;
      case 'user-disabled':
        break;
      case 'user-not-found':
        break;
      case 'wrong-password':
        break;
    }
  }
}