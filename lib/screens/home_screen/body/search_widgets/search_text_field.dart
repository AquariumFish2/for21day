import 'package:flutter/material.dart';
import 'package:Todo/controllers/search_controller.dart';
import 'package:Todo/variables/text_styles.dart';
import 'package:provider/provider.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        onChanged: (v) => context.read<SearchController>().onChanged(v),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          hintText: 'search',
          hintStyle: TextStyles.textFieldTextStyle,
        ),
      ),
    );
  }
}
