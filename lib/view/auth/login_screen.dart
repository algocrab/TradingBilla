import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

import 'component/custom_elevated_button.dart';
import 'component/custom_image.dart';
import 'component/custom_text_field.dart';
import 'component/google_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          CustomImage(
            imageURL: 'assets/login.svg',
          ),


          Padding(
            padding: const EdgeInsets.only(top: 30,left: 20),
            child: Row(
              children: [
                Text('Login',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Cairo'
                ),
                )
              ],
            ),
          ),

          CustomTextField(
            icon: Icon(Icons.alternate_email),
            label: 'Email Address',
          ),

          CustomTextField(
            icon: Icon(Iconsax.lock),
            label: 'Password',
          ),



          Row(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20,bottom: 0,top: 10),
                child: InkWell(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, '/forget_password');
                  },
                  child: Text('forget Password?',
                  style: TextStyle(
                    color: HexColor("#F5BD04"),
                  ),
                  ),
                )
              )
            ],
          ),


          CustomElevatedButton(
            text: 'Submit',
            function: (){},
          ),


          Padding(
            padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 1,
                    color: Colors.grey,
                    width: 120,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('OR'),
                ),

                Expanded(
                  flex: 4,
                  child: Container(
                    height: 1,
                    color: Colors.grey,
                    width: 120,
                  ),
                ),
              ],
            ),
          ),

          GoogleButton(),


          Padding(
            padding: const EdgeInsets.only(
              top: 30
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('New to Logistics ? '),
                InkWell(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, '/register_screen');
                  },
                  child: Text('Register',

                  style: TextStyle(
                    color: HexColor("#F5BD04"),
                  ),
                  ),
                ),

              ],
            ),
          ),


        ],
      ),

    );
  }
}




