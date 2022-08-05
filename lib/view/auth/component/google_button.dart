import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,top:15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey.shade100,
          elevation: 0,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),// NEW
        ),
        onPressed: (){},
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Image.asset('assets/google1.png',
                width: 40,
                height: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: Text('Login with Google',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
