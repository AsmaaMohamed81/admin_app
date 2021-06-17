import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final Alignment alignment;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomText(
      {Key key,
      this.text,
      this.color = Colors.black,
      this.alignment,
      this.fontSize = 16,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        style:
            TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}
