import 'package:flutter/material.dart';
import 'package:news/utils/app_styles.dart';

class DrawerItem extends StatelessWidget {
  String image;
  String text;
  DrawerItem({required this.image, required this.text});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Image.asset(image),
        SizedBox(width: width * 0.02),
        Text(text, style: AppStyles.bold20White),
      ],
    );
  }
}
