import 'package:flutter/material.dart';
import 'package:for21day/controllers/category_controller.dart';
import 'package:for21day/models/category.dart';
import 'package:for21day/screens/add_todo_screen/widgets/add_category_dialoge.dart';
import 'package:for21day/screens/add_todo_screen/widgets/info_text.dart';
import 'package:for21day/variables/colors.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddTODOCategoryList extends StatelessWidget {
  const AddTODOCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoText(text: 'chose the list'),
        Consumer<CategoryController>(builder: (context, categoryController, _) {
          return Row(
            children: [
              SizedBox(
                width: 80.w,
                child: Card(
                  elevation: 0,
                  color: Colors.white.withOpacity(0),
                  margin: const EdgeInsets.only(top: 8, bottom: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                          color: AppColors.primaryColor.withOpacity(0.6))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: DropdownButton(
                      isExpanded: true,
                      value: categoryController.selectedCategory,
                      items: categoryController.categories
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Row(
                                children: [
                                  Text(e.name),
                                  // Spacer(),
                                  // IconButton(
                                  //     onPressed: () =>
                                  //         categoryController.removeCategory(e),
                                  //     icon: Icon(
                                  //       Icons.delete,
                                  //       color: Colors.red,
                                  //     ))
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) =>
                          categoryController.selectCategory(v as Category),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AddCategoryDiaglog());
                },
              ))
            ],
          );
        }),
      ],
    );
  }
}
