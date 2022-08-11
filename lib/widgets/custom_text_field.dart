import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final Icon icon;
  final TextEditingController controller;
  final TextInputType textInputType;

  CustomTextField({
    required this.icon,
    required this.label,
    required this.controller,
    required this.textInputType,
});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: IconButton(onPressed: (){}, icon:icon),
            )),
        Expanded(
          flex:6,
          child: Padding(
            padding: const EdgeInsets.only(right: 20,bottom: 7),
            child: TextField(

              controller: controller,
            keyboardType: textInputType,

            cursorColor: Colors.grey,
              decoration: InputDecoration(

                labelStyle: TextStyle(color: Colors.grey),
                  label: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(label,
                      style: TextStyle(
                          fontFamily: 'CiroRegular'
                      ),
                    ),
                  ),

                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),

              ),
            ),
          ),
        ),
      ],
    );
  }
}
