import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomImage extends StatelessWidget {
  final String imageURL;

  CustomImage({
    required this.imageURL,
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,top: 60,right: 20),
      child: Container(
        height: 200,
        child:SvgPicture.asset(imageURL),
      ),
    );
  }
}