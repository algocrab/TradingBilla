import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

import 'component/custom_elevated_button.dart';
import 'component/custom_image.dart';
import 'component/custom_text_field.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacementNamed(context, '/login_screen');
          },
          icon: Icon(Icons.arrow_back,color: Colors.black,),
        ),
      ),
      body: ListView(
        children: [
          CustomImage(
            imageURL: 'assets/register.svg',
          ),


          Padding(
            padding: const EdgeInsets.only(top: 30,left: 20),
            child: Row(
              children: [
                Text('Sign Up',
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
            label: 'Email',
          ),

          CustomTextField(
            icon: Icon(Iconsax.personalcard),
            label: 'Full name',
          ),
          CustomTextField(
            icon: Icon(Iconsax.lock),
            label: 'password',
          ),




          Padding(
              padding: const EdgeInsets.only(top: 15,left: 15,right: 10),
              child: RichText(
                text: TextSpan(
                  text: 'To sining up your agree to our ',
                  style: TextStyle(color: Colors.black,
                    fontSize: 15.0,
                  ),
                  children: const <TextSpan>[
                    TextSpan(text: 'Terms & Conditions', style: TextStyle(fontWeight: FontWeight.bold,)),
                    TextSpan(text: ' Privacy Policy', style: TextStyle(fontWeight: FontWeight.bold,)),
                  ],
                ),
              )
          ),



          CustomElevatedButton(
            text: 'Register Now',
            function: (){},
          ),

          Padding(
            padding: const EdgeInsets.only(
                top: 50
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('have an account ? '),
                InkWell(
                  onTap: (){
                    Navigator.pushReplacementNamed(context,'/login_screen');
                  },
                  child: Text('Login',

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
