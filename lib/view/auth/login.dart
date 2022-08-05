import 'package:flutter/material.dart';

import 'component/custom_elevated_button.dart';
import 'component/custom_image.dart';
import 'component/custom_text_field.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
            icon: Icon(Icons.phone),
            label: 'Mobile',
          ),

          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: CustomElevatedButton(
              text: 'Login',
              function: (){},
            ),
          ),


        ],
      ),
    );
  }
}
