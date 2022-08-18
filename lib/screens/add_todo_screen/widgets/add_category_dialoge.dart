import 'package:flutter/material.dart';
import 'package:for21day/controllers/category_controller.dart';
import 'package:for21day/screens/add_todo_screen/widgets/info_text.dart';
import 'package:for21day/variables/borders.dart';
import 'package:for21day/variables/colors.dart';
import 'package:for21day/variables/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddCategoryDiaglog extends StatelessWidget {
  const AddCategoryDiaglog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryController>(builder: (context, catController, _) {
      return SizedBox(
        height: 50.h,
        width: 50.w,
        child: Dialog(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 6.h),
                      child: const InfoText(text: 'Add Category'),
                    ),
                    TextField(
                      controller: catController.addCategoryController,
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        hintText: 'Category name',
                        helperStyle: TextStyles.textFieldTextStyle,
                        border: Appborders.textFieldBorder,
                        errorBorder: Appborders.textFieldBorder,
                        enabledBorder: Appborders.textFieldBorder,
                        focusedBorder: Appborders.textFieldBorder,
                        disabledBorder: Appborders.textFieldBorder,
                        focusedErrorBorder: Appborders.textFieldBorder,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          catController.addCateogry(context);
                        },
                        child: Text(
                          'Ok',
                          style: TextStyles.infoTextStyle,
                        )),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyles.infoTextStyle,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
