import 'package:flutter/material.dart';
import 'package:Todo/variables/text_styles.dart';

class InfoText extends StatelessWidget {
  const InfoText({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.infoTextStyle,
    );
  }
}
