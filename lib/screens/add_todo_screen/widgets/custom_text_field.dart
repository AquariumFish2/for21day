import 'package:flutter/material.dart';
import 'package:for21day/variables/borders.dart';
import 'package:for21day/variables/colors.dart';
import 'package:for21day/variables/text_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.onValidate,
    required this.textKey,
    this.onSelect,
    this.readOnly,
  }) : super(key: key);
  final TextEditingController controller;
  final Key textKey;
  final String hint;
  final Function onValidate;
  final bool? readOnly;
  final Function? onSelect;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        validator: (v) => onValidate(v),
        controller: controller,
        onTap: onSelect != null ? () => onSelect!() : null,
        readOnly: readOnly ?? false,
        style: TextStyles.textFieldTextStyle,
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyles.textFieldTextStyle,
          focusedBorder: Appborders.textFieldBorder,
          border: Appborders.textFieldBorder,
        ),
      ),
    );
  }
}
