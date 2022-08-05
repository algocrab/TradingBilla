import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trading_billa/shared-preferences/user_preferences_controler.dart';
import 'package:trading_billa/view/auth/forget_password.dart';
import 'package:trading_billa/view/auth/login.dart';
import 'package:trading_billa/view/auth/login_screen.dart';
import 'package:trading_billa/view/auth/register_screen.dart';
import 'package:trading_billa/view/auth/reset_password.dart';
import 'package:trading_billa/view/auth/verify_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferenceController().initSharedPreference();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: '/login_screen',
        routes: {
          '/login_screen': (context) => LoginScreen(),
          '/register_screen': (context) => RegisterScreen(),
          '/forget_password': (context) => ForgetPassword(),
          '/verify_screen': (context) => VerifyScreen(),
          '/reset_password': (context) => ResetPassword(),
          '/login_user': (context) => Login(),
        },
    );
  }
}
