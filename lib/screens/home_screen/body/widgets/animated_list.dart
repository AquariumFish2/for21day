import 'package:flutter/material.dart';
import 'package:for21day/controllers/note_controller.dart';
import 'package:for21day/screens/home_screen/body/widgets/note_view_model.dart';
import 'package:provider/provider.dart';


class NotesAnimatedList extends StatelessWidget {
  const NotesAnimatedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteController>(builder: (context, notesController, _) {
      return ListView.builder(
        itemCount: notesController.notes.length,
        itemBuilder: (context, index) =>
            NoteViewModel(note: notesController.notes[index], index: index),
      );
    });
  }
}
