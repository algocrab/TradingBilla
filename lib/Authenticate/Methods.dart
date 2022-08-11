import 'package:test_app_chat/Authenticate/LoginScree.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'User/login.dart';

Future<User?> createAccount(String name, String email, String password,) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCrendetial = await _auth.createUserWithEmailAndPassword(
        email: email,password: password);

    print("Account created Succesfull");

    userCrendetial.user!.updateDisplayName(name);

    await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
      "name": name,
      "email": email,
      "status": "Unavalible",
      "uid": _auth.currentUser!.uid,
      "phone":"",
    });

    await FirebaseFirestore.instance
        .collection('basic-group')
        .doc('NM6GQFTiF8rfCHzL5obP')
        .update({
      'members':
      FieldValue.arrayUnion([
        {
          'name': name,
          'email': email,
          'uid': _auth.currentUser!.uid,
          'isAdmin':false,
          'joinedAt': Timestamp.now(),
        }
      ]),
    });




    return userCrendetial.user;
  } catch (e) {
    print(e);
    return null;
  }
}






Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    print("Login Sucessfull");
    _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => userCredential.user!.updateDisplayName(value['name']));

    return userCredential.user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LogInPage()));
    });
  } catch (e) {
    print("error");
  }
}
