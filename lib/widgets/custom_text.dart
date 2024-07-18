import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final String? fontFamily;
  final TextAlign? textAlign;

  // name constructor that has a positional parameters with the text required
  // and the other parameters optional
  CustomText(
      {required this.text,
      this.size,
      this.color,
      this.weight,
      this.textAlign,
      this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size ?? 14,
          color: color ?? Colors.black,
          fontFamily: fontFamily,
          fontWeight: weight ?? FontWeight.normal),
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
