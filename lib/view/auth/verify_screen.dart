import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'component/custom_elevated_button.dart';
import 'component/custom_image.dart';
class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacementNamed(context,'/login_screen');
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      body: ListView(
        children: [
          CustomImage(
            imageURL: 'assets/verify.svg',
          ),


          Padding(
            padding: const EdgeInsets.only(top: 30,left: 20),
            child: Row(
              children: [
                Text('Enter OTP',
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

          Padding(
              padding: const EdgeInsets.only(top: 15,left: 15,right: 10),
              child:Text('An 6 digit code has been send to',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18
              ),
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 10, top: 7),
            child:Text('+970 594133816',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18
              ),
            ),
          ),

          _buildPinCodeFields(context),


          CustomElevatedButton(
            text: 'Submit',
            function: (){},
          ),
        ],
      ),
    );
  }
  Widget _buildPinCodeFields(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 40),
      child: Container(
        child: PinCodeTextField(
          appContext: context,
          autoFocus: true,
          cursorColor: Colors.black,
          keyboardType: TextInputType.number,
          length: 6,
          obscureText: false,
          animationType: AnimationType.scale,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            borderWidth: 1,
            activeColor:  HexColor("#F5BD04"),
            inactiveColor:  HexColor("#F5BD04"),
            inactiveFillColor: Colors.white,
            activeFillColor: Colors.grey.shade100,
            selectedColor:  HexColor("#F5BD04"),
            selectedFillColor: Colors.white,
          ),
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.white,
          enableActiveFill: true,
          onCompleted: (submitedCode) {
            // otpCode = submitedCode;
            print("Completed");
          },
          onChanged: (value) {
            print(value);
          },
        ),
      ),
    );
  }
}
