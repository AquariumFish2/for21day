import 'package:flutter/material.dart';
import 'package:Todo/controllers/note_controller.dart';
import 'package:Todo/controllers/search_controller.dart';
import 'package:Todo/variables/colors.dart';
import 'package:Todo/variables/text_styles.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../models/note.dart';

class NoteViewModel extends StatelessWidget {
  const NoteViewModel(
      {Key? key, required this.note, required this.index, this.onSearchMode})
      : super(key: key);
  final Note note;
  final int index;
  final bool? onSearchMode;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Consumer<NoteController>(
        builder: (context, noteController, child) => InkWell(
          onTap: (() {
            noteController.editNote(note, context);
          }),
          child: SizedBox(
            height: 100,
            child: Card(
              key: UniqueKey(),
              color: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<NoteController>().doneCheckBox(note,context);
                      },
                      icon: Icon(
                        (!note.isDone)
                            ? Icons.check_box_outline_blank
                            : Icons.check_box,
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.data,
                          style: TextStyles.noteNameTextStyle,
                        ),
                        Row(
                          children: [
                            Text(
                              DateFormat("yyyy-MM-dd-hh:mm")
                                  .format(note.dueDate),
                              style: TextStyles.noteDateTimeTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        if (onSearchMode != null) {
                          context
                              .read<SearchController>()
                              .deleteNote(note, context);
                        }
                        context.read<NoteController>().deleteNote(note,context);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
