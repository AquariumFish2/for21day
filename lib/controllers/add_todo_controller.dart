import 'package:flutter/material.dart';
import 'package:for21day/controllers/category_controller.dart';
import 'package:for21day/controllers/note_controller.dart';
import 'package:for21day/models/note.dart';
import 'package:for21day/screens/home_screen/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTodoController extends ChangeNotifier {
  DateTime? taskDate;

  //!initializing the text controllers here to keep the text for a better user experience

  TextEditingController todoNameController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  formClear() {
    todoNameController = TextEditingController();
    dateController = TextEditingController();
    timeController = TextEditingController();
    taskDate = null;
    notifyListeners();
  }

  //* this function is to display the time picker textfield
  updateDate() {
    taskDate = DateTime.parse(dateController.text);
    notifyListeners();
  }

  //? to add the time of the method we have to parse manually the text of the controller to [TimeOfDay]
  //? so we added to function one to get the hours and the other to get the minutes and then we make
  //? an initial value from them and add it to the note [TimeOfDay]
  int getHoursFromString() {
    return int.parse(
      timeController.text.substring(
        0,
        timeController.text.indexOf(':'),
      ),
    );
  }

  int getMinutesFromString() {
    return int.parse(
      timeController.text.substring(
        timeController.text.indexOf(':') + 1,
        timeController.text.indexOf(':') + 3,
      ),
    );
  }

  //* onsave we use the note controller to save the note to the db then we get all the notes so the new
  //* note can be displayed in the runtime
  onSave(GlobalKey<FormState> formKey, BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (context.read<NoteController>().selectedNote != null) {
        context.read<NoteController>().selectedNote!.data =
            todoNameController.text;
        context.read<NoteController>().selectedNote!.dueDate =
            DateTime.parse(dateController.text).add(
          Duration(
            minutes: getMinutesFromString(),
            hours: getHoursFromString(),
          ),
        );
        context.read<NoteController>().selectedNote!.time = timeController.text;
        context.read<NoteController>().saveEdit();
        // context.read<NoteController>().selectedNote = null,
      } else {
        context.read<NoteController>().addNote(
            Note(
              data: todoNameController.text,
              addDate: DateTime.now(),
              dueDate: DateTime.parse(dateController.text).add(
                Duration(
                  minutes: getMinutesFromString(),
                  hours: getHoursFromString(),
                ),
              ),
              time: timeController.text,
            ),
            context);
      }

      //? after adding the note to the database we navigate back and give initial values to the controllers
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((context) => const HomeScreen())),
          (route) => false);
      formClear();
    }
  }

  setValuesToTextControllers(Note note) {
    taskDate = note.dueDate;
    todoNameController.text = note.data;
    dateController.text = DateFormat('yyyy-MM-dd').format(note.dueDate);
    timeController.text = note.time!;
    notifyListeners();
  }
}
