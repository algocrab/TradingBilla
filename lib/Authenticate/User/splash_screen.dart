import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app_chat/Screens/HomeScreen.dart';

import '../../Screens/app.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      //search_chat_screen
      final FirebaseAuth _auth = FirebaseAuth.instance;
      if (_auth.currentUser != null) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return LogInPage();
          },
        ));
      } else {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return LogInPage();
          },
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 340,
              child: Image.asset(
                'assets/thumb_trading_billa.jpeg',
                // fit: BoxFit.cover,
                // height: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
