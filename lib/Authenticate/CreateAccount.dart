import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:test_app_chat/Authenticate/Methods.dart';
import 'package:flutter/material.dart';
import 'package:test_app_chat/Screens/app.dart';
import 'package:test_app_chat/widgets/custom_elevated_button.dart';
import '../Screens/HomeScreen.dart';
import '../widgets/custom_text_field.dart';

class CreateAccount extends StatefulWidget {
  final String phoneNumber;
  CreateAccount({
    required this.phoneNumber,
});
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            // Navigator.pushReplacementNamed(context, '/login_screen');
          },
          icon: Icon(Icons.arrow_back,color: Colors.black,),
        ),
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child:  LoadingAnimationWidget.dotsTriangle(
                  color: HexColor("#F5BD04"),
                  size: 30,
                ),
              ),
            )
          : ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 60,right: 20),
                child: Container(
                  height: 150,
                  child:SvgPicture.asset('assets/register.svg'),
                ),
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


              SizedBox(
                height: size.height / 20,
              ),


              CustomTextField(
                icon: Icon(Icons.alternate_email),
                label: 'Email',
                controller: _email,
                textInputType: TextInputType.emailAddress,
              ),

              CustomTextField(
                icon: Icon(Iconsax.personalcard),
                label: 'Full name',
                controller: _name,
                textInputType: TextInputType.text,
              ),
              CustomTextField(
                icon: Icon(Iconsax.lock),
                label: 'password',
                controller: _password,
                textInputType: TextInputType.visiblePassword,
              ),
              SizedBox(
                height: size.height / 20,
              ),
              CustomElevatedButton(function: (){
            createAccount(_name.text, _email.text, _password.text).then((value) =>
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AppScreen()))
            );
              },
                  text:"Add your data",
              )
            ],
          ),
    );
  }
}


// add phone number to firestore to search by phone
