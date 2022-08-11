import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:test_app_chat/Authenticate/CreateAccount.dart';

import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_image.dart';


class OTPPage extends StatefulWidget {
  OTPPage({required this.verificationId, required this.isTimeOut2, required this.phoneNumber});
  final String verificationId;
  final bool isTimeOut2;
  final String phoneNumber;

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {

  final otpController = TextEditingController();
  bool showLoading = false;
  String verificationFailedMessage = "";
  final FirebaseAuth auth = FirebaseAuth.instance;

  String myVerificationId = "";
  bool isTimeOut = false;


  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    myVerificationId = widget.verificationId;
    isTimeOut = widget.isTimeOut2;
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    showLoading
        ? Center(
      child:  LoadingAnimationWidget.dotsTriangle(
        color: HexColor("#F5BD04"),
        size: 30,
      ),
    )
        :
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        // height: 300,
        child: ListView(
          children: <Widget>[
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
            child:Text('${widget.phoneNumber}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18
              ),
            ),
          ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't receive the code? ",
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
                TextButton(
                    onPressed: isTimeOut ? () async {
                      setState(() {
                        isTimeOut =  false;
                      });
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '${widget.phoneNumber}',
                        verificationCompleted: (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {
                          setState(() {
                            showLoading = false;
                          });
                          setState(() {
                            verificationFailedMessage = e.message ?? "error!";
                          });
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          setState(() {
                            showLoading = false;
                            myVerificationId = verificationId;
                          });
                        },
                        timeout: const Duration(seconds: 10),
                        codeAutoRetrievalTimeout: (String verificationId) {
                          setState(() {
                            isTimeOut =  true;
                          });
                        },
                      );
                    }
                    : null,
                    child: Text(
                      "RESEND",
                      style: TextStyle(
                          color: HexColor("#F5BD04"),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ))
              ],
            ),

            Form(
              key: formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 6|| currentText != otpController) {
                        return "you should enter all SMS code";
                      }
                      else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeColor:  HexColor("#F5BD04"),
                      inactiveColor:  HexColor("#F5BD04"),
                      inactiveFillColor: Colors.white,
                      activeFillColor: Colors.grey.shade100,
                      selectedColor:  HexColor("#F5BD04"),
                      selectedFillColor: Colors.white,
                    ),

                    cursorColor: Colors.black,
                    animationDuration: Duration(milliseconds: 300),
                    errorAnimationController: errorController,
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    boxShadows: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.white,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                  )),
            ),




            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    primary: HexColor("#F5BD04")
                  ),
                  onPressed: ()async {

                    formKey.currentState!.validate();
                    // conditions for validating
                    if (currentText.length != 6) {
                      errorController!.add(ErrorAnimationType
                          .shake); // Triggering error shake animation
                      setState(() => hasError = true);
                    } else {
                      setState(
                            () {
                          hasError = false;
                        },
                      );
                      setState(() {
                        showLoading = true;
                      });

                      try{
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: myVerificationId, smsCode: otpController.text);

                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);

                      }on FirebaseAuthException catch (e){
                        setState(() {
                          verificationFailedMessage = e.message ?? "error";
                        });
                      }

                      setState(() {
                        showLoading = false;
                      });
                      if(auth.currentUser != null){
                        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_,__,___) => CreateAccount(phoneNumber: widget.phoneNumber,)));
                      }
                    }

                  },
                  child: Text("VERIFY"),
                ),
                // decoration: BoxDecoration(
                //     color: HexColor("#F5BD04"),
                //     borderRadius: BorderRadius.circular(5),
                //
                //
                // ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 100,
                // color: Colors.white,
                child: ListTile(
                  title: Center(child: Text(verificationFailedMessage,style: TextStyle(
                    color: Colors.grey,
                  ),
                  ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ), );
  }
}







