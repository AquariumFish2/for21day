import 'package:flutter/material.dart';
import 'package:for21day/controllers/add_todo_controller.dart';
import 'package:for21day/controllers/note_controller.dart';
import 'package:for21day/variables/colors.dart';
import 'package:for21day/variables/text_styles.dart';
import 'package:provider/provider.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({Key? key, required this.formKey}) : super(key: key);
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
      ),
      onPressed: () async {
        context.read<AddTodoController>().onSave(formKey, context);
        context.read<NoteController>().getNotes(context);
      },
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Save',
              style: TextStyles.buttonTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
