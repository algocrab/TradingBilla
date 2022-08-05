import 'package:flutter/material.dart';
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
    Future.delayed(Duration(seconds: 3),(){
      // String routeName =StudentPreferenceController().loggedIn ?'/users_screen':'/login_screen';
      // Navigator.pushReplacementNamed(context, routeName);
      Navigator.pushReplacementNamed(context, '/login_screen');
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
             width: 300,
             child:  Image.asset('assets/thumb_trading_billa.jpeg',
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
