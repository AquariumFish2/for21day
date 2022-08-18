import 'package:flutter/material.dart';
import 'package:for21day/controllers/add_todo_controller.dart';
import 'package:for21day/screens/add_todo_screen/widgets/add_todo_category_list.dart';
import 'package:for21day/screens/add_todo_screen/widgets/custom_text_field.dart';
import 'package:for21day/screens/add_todo_screen/widgets/info_text.dart';
import 'package:for21day/screens/add_todo_screen/widgets/save_button.dart';
import 'package:for21day/screens/home_screen/body/widgets/categories_drop_down_button.dart';
import 'package:for21day/screens/home_screen/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey();

  final Key todoNameKey = UniqueKey();

  final Key dateKey = UniqueKey();

  final Key timeKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        leading: IconButton(
          onPressed: () {
            context.read<AddTodoController>().formClear();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (ctx) => const HomeScreen()),
                ((route) => false));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AddTodoController>().formClear();
              },
              icon: const Icon(Icons.no_sim_outlined))
        ],
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Consumer<AddTodoController>(
              builder: (context, addTodoController, _) {
            return ListView(
              children: [
                const InfoText(text: "todo what ?"),
                CustomTextField(
                  controller: addTodoController.todoNameController,
                  textKey: todoNameKey,
                  hint: "Enter Task Name",
                  onValidate: (String v) {
                    if (v.isEmpty) {
                      return "please type a valid name";
                    }
                  },
                ),
                const InfoText(text: "due date"),
                // on tab we select the date and review it on the same textfield
                CustomTextField(
                  controller: addTodoController.dateController,
                  hint: "Select Date",
                  textKey: dateKey,
                  onValidate: (String v) {
                    if (v.isEmpty) {
                      return "please select the date";
                    }
                  },
                  readOnly: true,
                  onSelect: () async {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        const Duration(days: 365),
                      ),
                    ).then((value) {
                      if (value != null) {
                        addTodoController.dateController.text =
                            DateFormat("yyyy-MM-dd").format(value);
                        context.read<AddTodoController>().updateDate();
                      }
                    });
                  },
                ),
                if (context.watch<AddTodoController>().taskDate != null)
                  const InfoText(text: "due Time"),
                if (context.watch<AddTodoController>().taskDate != null)
                  CustomTextField(
                    controller: addTodoController.timeController,
                    textKey: timeKey,
                    hint: "Select Time",
                    onValidate: (String v) {
                      if (v.isEmpty) {
                        return 'please select the time';
                      }
                    },
                    readOnly: true,
                    onSelect: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) {
                        if (value != null) {
                          addTodoController.timeController.text =
                              value.format(context);
                        }
                      });
                    },
                  ),
                if (context.watch<AddTodoController>().taskDate != null)
                  const AddTODOCategoryList(),
                SaveButton(formKey: formKey),
              ],
            );
          }),
        ),
      ),
    );
  }
}
