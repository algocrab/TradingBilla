import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';

import 'component/custom_elevated_button.dart';
import 'component/custom_image.dart';
import 'component/custom_text_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
            imageURL: 'assets/reset.svg',
          ),


          CustomTextField(
            icon: Icon(Iconsax.lock),
            label: 'Password',
          ),



          CustomTextField(
            icon: Icon(Iconsax.lock),
            label: 'Confirm password',
          ),



          CustomElevatedButton(
            text: 'Reset Password',
            function: (){},
          ),


        ],
      ),
    );
  }
}
