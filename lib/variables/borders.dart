import 'package:flutter/material.dart';
import 'package:Todo/variables/colors.dart';

abstract class Appborders {
  static OutlineInputBorder textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(
      width: 2,
      color: AppColors.buttonsColor,
    ),
  );
}
