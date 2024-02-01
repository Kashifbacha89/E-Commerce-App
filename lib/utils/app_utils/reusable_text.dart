import 'package:flutter/material.dart';
class ReusableText extends StatelessWidget {
  const ReusableText({Key? key, required this.text, required this.style}) : super(key: key);
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return  Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.fade,
      textAlign: TextAlign.left,
      softWrap: false,
      style: style,

    );
  }
}
