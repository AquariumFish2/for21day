import 'package:flutter/cupertino.dart';
import 'package:Todo/controllers/note_controller.dart';
import 'package:Todo/helpers/store_helper.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class SearchController extends ChangeNotifier {
  bool search = false;

  List<Note> _searchedNotes = [];

  List<Note> _allNotes = [];

  List<Note> get searchedNotes => _searchedNotes;

  getNotes() {
    _allNotes = StaticStore.store.box<Note>().getAll();
    _searchedNotes = _allNotes;
    notifyListeners();
  }

  toggleSearch() {
    search = !search;
    getNotes();
    notifyListeners();
  }

  onChanged(String v) {
    _searchedNotes =
        _allNotes.where((element) => element.data.contains(v)).toList();
    notifyListeners();
  }

  deleteNote(Note note,BuildContext context) {
    _allNotes.remove(note);
    _searchedNotes.remove(note);
    context.read<NoteController>().deleteNote(note,context);
    notifyListeners();
  }
}
