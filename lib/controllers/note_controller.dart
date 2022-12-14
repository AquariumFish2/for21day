import 'package:flutter/material.dart';
import 'package:Todo/controllers/add_todo_controller.dart';
import 'package:Todo/controllers/category_controller.dart';
import 'package:Todo/controllers/notification_controller.dart';
import 'package:Todo/helpers/store_helper.dart';
import 'package:Todo/models/note.dart';
import 'package:Todo/screens/add_todo_screen/add_todo_screen.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';

class NoteController extends ChangeNotifier {
  NoteController(BuildContext context) {
    getNotes(context);
  }
  Note? selectedNote;

  List<Note> _notes = [];

  List<Note> get notes => _notes;

  int addNote(Note note, BuildContext context) {
    note.category.targetId =
        context.read<CategoryController>().selectedCategory!.id;
    int id = StaticStore.store.box<Note>().put(note);
    _notes = StaticStore.store.box<Note>().getAll();
    notifyListeners();
    return id;
  }

  getNotes(BuildContext context) {
    Category? category = context.read<CategoryController>().selectedCategory;
    if (category != null &&
        category.name.toLowerCase() != 'done' &&
        category.name.toLowerCase() != 'all lists') {
      for (var element in category.notes) {
        if (!element.isDone) {
          notes.add(element);
        }
      }
    } else if (category != null && category.name.toLowerCase() == 'done') {
      print('done');
      for (var element in category.notes) {
        if (element.isDone) {
          notes.add(element);
        }
      }
    } else if ((category != null &&
            category.name.toLowerCase() == 'all lists') ||
        category == null) {
      _notes = StaticStore.store.box<Note>().getAll();
    }
  }

  //! on one tap
  editNote(Note note, BuildContext context) {
    selectedNote = note;
    context.read<AddTodoController>().setValuesToTextControllers(selectedNote!);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AddTodoScreen()),
        (route) => false);
    notifyListeners();
  }

  //? save after editing after tapping on the task
  saveEdit() {
    StaticStore.store.box<Note>().put(selectedNote!);
    _notes = StaticStore.store.box<Note>().getAll();
    selectedNote = null;
    notifyListeners();
  }

  deleteNote(Note note, BuildContext context) async {
    StaticStore.store.box<Note>().remove(note.id);
    _notes = StaticStore.store.box<Note>().getAll();
    context.read<NotificationController>().service.cancelNotification(note.id);
    notifyListeners();
  }

  doneCheckBox(Note note, BuildContext context) {
    if (note.dueDate.isAfter(DateTime.now())) {
      note.isDone = !note.isDone;
      if (note.isDone) {
        context
            .read<NotificationController>()
            .service
            .cancelNotification(note.id);
      } else {
        context.read<NotificationController>().showNotification(note, note.id);
      }
      StaticStore.store.box<Note>().put(note);
      getNotesFromCategory(context);
      notifyListeners();
    }
  }

  getNotesFromCategory(BuildContext context) {
    context.read<CategoryController>().getAllCategories();
    Category? category = context.read<CategoryController>().selectedCategory;
    _notes = [];
    if (category != null &&
        category.name != 'done' &&
        category.name != 'All Lists') {
      print(category.notes);
      _notes = category.notes;
      notifyListeners();
    } else if (category != null && category.name == 'done') {
      for (var element in StaticStore.store.box<Note>().getAll()) {
        if (element.isDone) {
          _notes.add(element);
          print(element.category.target!.name);
        }
        notifyListeners();
      }
    } else if ((category != null && category.name == 'All Lists') ||
        category == null) {
      _notes.addAll(StaticStore.store.box<Note>().getAll());
      notifyListeners();
    }
  }
}
