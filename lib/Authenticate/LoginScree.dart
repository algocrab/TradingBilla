// import 'package:test_app_chat/Authenticate/CreateAccount.dart';
// import 'package:test_app_chat/Screens/HomeScreen.dart';
// import 'package:test_app_chat/Authenticate/Methods.dart';
// import 'package:flutter/material.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _password = TextEditingController();
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       body: isLoading
//           ? Center(
//               child: Container(
//                 height: size.height / 20,
//                 width: size.height / 20,
//                 child: CircularProgressIndicator(),
//               ),
//             )
//           : SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: size.height / 20,
//                   ),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     width: size.width / 0.5,
//                     child: IconButton(
//                         icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
//                   ),
//                   SizedBox(
//                     height: size.height / 50,
//                   ),
//                   Container(
//                     width: size.width / 1.1,
//                     child: Text(
//                       "Welcome",
//                       style: TextStyle(
//                         fontSize: 34,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: size.width / 1.1,
//                     child: Text(
//                       "Sign In to Contiue!",
//                       style: TextStyle(
//                         color: Colors.grey[700],
//                         fontSize: 25,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: size.height / 10,
//                   ),
//                   Container(
//                     width: size.width,
//                     alignment: Alignment.center,
//                     child: field(size, "email", Icons.account_box, _email),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 18.0),
//                     child: Container(
//                       width: size.width,
//                       alignment: Alignment.center,
//                       child: field(size, "password", Icons.lock, _password),
//                     ),
//                   ),
//                   SizedBox(
//                     height: size.height / 10,
//                   ),
//                   customButton(size),
//                   SizedBox(
//                     height: size.height / 40,
//                   ),
//                   GestureDetector(
//                     onTap: () => Navigator.of(context).push(
//                         MaterialPageRoute(builder: (_) => CreateAccount(phoneNumber: '',))),
//                     child: Text(
//                       "Create Account",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//     );
//   }
//
//   Widget customButton(Size size) {
//     return GestureDetector(
//       onTap: () {
//         if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
//           setState(() {
//             isLoading = true;
//           });
//
//           logIn(_email.text, _password.text).then((user){
//             if (user != null) {
//               print("Login Sucessfull");
//               setState(() {
//                 isLoading = false;
//               });
//               // Navigator.push(
//               //     context, MaterialPageRoute(builder: (_) => HomeScreen()));
//             } else {
//               print("Login Failed");
//               setState(() {
//                 isLoading = false;
//               });
//             }
//           });
//         } else {
//           print("Please fill form correctly");
//         }
//       },
//       child: Container(
//           height: size.height / 14,
//           width: size.width / 1.2,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: Colors.blue,
//           ),
//           alignment: Alignment.center,
//           child: Text(
//             "Login",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           )),
//     );
//   }
//
//   Widget field(
//       Size size, String hintText, IconData icon, TextEditingController cont) {
//     return Container(
//       height: size.height / 14,
//       width: size.width / 1.1,
//       child: TextField(
//         controller: cont,
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon),
//           hintText: hintText,
//           hintStyle: TextStyle(color: Colors.grey),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:test_app_chat/Authenticate/User/login.dart';
import 'package:test_app_chat/Screens/app.dart';

import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_image.dart';
import '../widgets/custom_text_field.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

import 'Methods.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   late TextEditingController emailController;
   late TextEditingController passwordController;
  bool isLoading = false;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController =  TextEditingController();
    passwordController =  TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose

    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


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
            controller: emailController,
            textInputType: TextInputType.emailAddress,
          ),

          CustomTextField(
            icon: Icon(Iconsax.lock),
            label: 'Password',
            controller: passwordController,
            textInputType: TextInputType.visiblePassword,
          ),



          Row(
            children: [
              Spacer(),
              Padding(
                  padding: const EdgeInsets.only(right: 20,bottom: 0,top: 10),
                  child: InkWell(
                    onTap: (){
                      // Navigator.pushReplacementNamed(context, '/forget_password');
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
            text: 'Login',
            function: (){

        if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          logIn(emailController.text, passwordController.text).then((user){
            if (user != null) {
              print("Login Sucessfull");
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AppScreen()));
            } else {
              print("Login Failed");
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please fill form correctly");
        }

            },
          ),
          SizedBox(
            height: 30,
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
              top: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login Via OTP',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
                )
              ],
            ),
          ),
          CustomElevatedButton(function: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) {
              return LogInPage();
            },));
          }, text: 'Verify Account')


        ],
      ),

    );
  }
}



