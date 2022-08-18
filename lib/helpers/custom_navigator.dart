import 'package:flutter/material.dart';

abstract class CustomNavigate {
  static void push(BuildContext context,Widget pageName) {
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => pageName)));
  }
}
