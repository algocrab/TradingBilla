import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function function;
  final String text;
  CustomElevatedButton({
    required this.function,
    required this.text,
});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,top:15),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: HexColor("#F5BD04"),
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),// NEW
          ),
          onPressed: (){
            function();
          },
          child: Text(text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20
            ),
          )
      ),
    );
  }
}

