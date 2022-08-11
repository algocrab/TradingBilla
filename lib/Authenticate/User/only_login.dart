import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:test_app_chat/Authenticate/LoginScree.dart';
import 'package:test_app_chat/Authenticate/User/verify_screen.dart';

import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_text_field.dart';

class OnlyLogin extends StatefulWidget {
  const OnlyLogin({Key? key}) : super(key: key);

  @override
  State<OnlyLogin> createState() => _OnlyLoginState();
}

class _OnlyLoginState extends State<OnlyLogin> {
  final phoneController = TextEditingController();
  bool showLoading = false;
  String verificationFailedMessage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showLoading
          ?  Center(
        child: LoadingAnimationWidget.dotsTriangle(
          color: HexColor("#F5BD04"),
          size: 30,
        ),
      )
          :

      ListView(
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
            textInputType: TextInputType.phone,
            controller: phoneController,
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CustomElevatedButton(
              text: 'Next',
              function: () async{

                setState(() {
                  showLoading = true;
                });
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: phoneController.text,
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
                    });
                    Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_,__,___) => OTPPage(
                      verificationId: verificationId,
                      isTimeOut2: false,
                      phoneNumber: phoneController.text,
                      // phoneNumber: phoneController.text
                    )

                    ));
                  },
                  timeout: const Duration(seconds: 10),
                  codeAutoRetrievalTimeout: (String verificationId) {

                    Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_,__,___) => OTPPage(
                      isTimeOut2: true ,
                      verificationId:verificationId,
                      phoneNumber: phoneController.text,
                    )));

                  },
                );

              },
            ),
          ),

          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 20,

                right: 20
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Text('OR'),
                ),


                Expanded(
                  flex: 2,
                  child: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(
                top: 20
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account ? ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),

          CustomElevatedButton(
              function: (){
                Navigator.push(context, MaterialPageRoute(builder:(context) {
                  return LoginScreen();
                },));
              }, text:'Login'),

          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Container(
              height: 60,
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
    );
  }
}


/*
 Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Spacer(),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  hintText: "Phone Number",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              FlatButton(
                onPressed: () async {

                  setState(() {
                    showLoading = true;
                  });
                  await FirebaseAuth.instance.verifyPhoneNumber(

                    phoneNumber: phoneController.text,
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
                      });
                      Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_,__,___) => OTPPage(isTimeOut2: false , verificationId:verificationId)));
                    },
                    timeout: const Duration(seconds: 10),
                    codeAutoRetrievalTimeout: (String verificationId) {

                      Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_,__,___) => OTPPage(isTimeOut2: true ,verificationId:verificationId)));

                    },
                  );
                },
                child: const Text("SEND"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
              SizedBox(
                height: 100,
              ),
              Text(verificationFailedMessage),
              Spacer(),
            ],
          ),
        )
 */