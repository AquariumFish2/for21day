import 'package:flutter/material.dart';
import 'package:for21day/controllers/category_controller.dart';
import 'package:for21day/controllers/note_controller.dart';
import 'package:for21day/models/category.dart';
import 'package:for21day/variables/colors.dart';
import 'package:for21day/variables/text_styles.dart';
import 'package:provider/provider.dart';

class CategoriesDropDownButton extends StatelessWidget {
  const CategoriesDropDownButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryController>(
        builder: (context, categoryController, _) {
      return DropdownButton(
        dropdownColor: AppColors.primaryColor,
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.white,
        underline: Container(
          height: 2,
          color: Colors.white,
        ),
        items: categoryController.categories
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e.name,
                    style: TextStyles.dropdownButtonTextStyle,
                  ),
                ))
            .toList(),
        hint: Text(
          "All Lists",
          style: TextStyles.dropdownButtonTextStyle,
        ),
        value: categoryController.selectedCategory,
        onChanged: (v) {
          categoryController.selectCategory(v as Category);
          context.read<NoteController>().getNotesFromCategory(context);
        },
      );
    });
  }
}
