import 'package:flutter/material.dart';
import 'package:for21day/controllers/add_todo_controller.dart';
import 'package:for21day/controllers/category_controller.dart';
import 'package:for21day/helpers/store_helper.dart';
import 'package:for21day/models/note.dart';
import 'package:for21day/screens/add_todo_screen/add_todo_screen.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';

class NoteController extends ChangeNotifier {
  Note? selectedNote;

  List<Note> _notes = [];

  List<Note> get notes => _notes;

  addNote(Note note, BuildContext context) async {
    note.category.target = context.read<CategoryController>().selectedCategory;
    StaticStore.store.box<Note>().put(note);
    StaticStore.store
        .box<Category>()
        .put(context.read<CategoryController>().selectedCategory!);
    _notes = StaticStore.store.box<Note>().getAll();
    notifyListeners();
  }

  getNotes(BuildContext context) {
    Category? category = context.read<CategoryController>().selectedCategory;
    if (category != null &&
        category.name != 'done' &&
        category.name != 'All Lists') {
      for (var element in category.notes) {
        if (!element.isDone) {
          notes.add(element);
        }
      }
    } else if (category != null && category.name == 'done') {
      for (var element in category.notes) {
        if (element.isDone) {
          notes.add(element);
        }
      }
    } else if ((category != null && category.name == 'All Lists') ||
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

  deleteNote(Note note, int index) async {
    StaticStore.store.box<Note>().remove(note.id);
    _notes = StaticStore.store.box<Note>().getAll();
    notifyListeners();
  }

  doneCheckBox(Note note) {
    note.isDone = !note.isDone;
    StaticStore.store.box<Note>().put(note);
    _notes = StaticStore.store.box<Note>().getAll();
    notifyListeners();
  }

  getNotesFromCategory(BuildContext context) {
    Category? category = context.read<CategoryController>().selectedCategory;
    _notes = [];
    if (category != null &&
        category.name != 'done' &&
        category.name != 'All Lists') {
      print(category.notes);
      _notes = category.notes;
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
