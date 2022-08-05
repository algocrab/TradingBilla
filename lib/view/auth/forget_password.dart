import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'component/custom_elevated_button.dart';
import 'component/custom_image.dart';
import 'component/custom_text_field.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
           imageURL: 'assets/forget.svg',
         ),

          Padding(
            padding: const EdgeInsets.only(top: 30,left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Forget'  ,style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: ''),),
                Text('Password ?',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: ''),),
              ],
            ),
          ),


         Padding(
             padding: const EdgeInsets.only(top: 15,left: 15,right: 10),
             child: RichText(
               text: TextSpan(
                 text: 'Don\'t worry , it happens ,please enter your email address or your mobile number' ,
                 style: TextStyle(color: Colors.grey,
                   fontSize: 15.0,
                   fontWeight: FontWeight.w600
                 ),

               ),
             )
         ),

         Padding(
           padding: const EdgeInsets.only(top: 20),
           child: CustomTextField(
             icon: Icon(Icons.alternate_email),
             label: 'Email address / Phone number',
           ),
         ),

         Padding(
           padding: const EdgeInsets.only(top: 30),
           child: CustomElevatedButton(
             text: 'Submit',
             function: (){},
           ),
         ),


       ],
      ),
    );
  }
}
