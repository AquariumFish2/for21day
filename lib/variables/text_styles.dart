import 'package:flutter/material.dart';
import 'package:for21day/variables/colors.dart';

abstract class TextStyles {
  static TextStyle dropdownButtonTextStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: null,
  );
  static TextStyle textFieldTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 22,
  );
  static TextStyle infoTextStyle = TextStyle(
    color: AppColors.buttonsColor,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static TextStyle buttonTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  static TextStyle noteNameTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  static TextStyle noteDateTimeTextStyle = const TextStyle(
    color: Colors.white70,
    fontSize: 18,
  );
}
