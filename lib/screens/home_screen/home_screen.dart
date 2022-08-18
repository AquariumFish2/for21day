import 'package:flutter/material.dart';
import 'package:for21day/controllers/note_controller.dart';
import 'package:for21day/controllers/search_controller.dart';
import 'package:for21day/screens/add_todo_screen/add_todo_screen.dart';
import 'package:for21day/screens/home_screen/body/search_widgets/back_icon.dart';
import 'package:for21day/screens/home_screen/body/search_widgets/search_list.dart';
import 'package:for21day/screens/home_screen/body/search_widgets/search_text_field.dart';
import 'package:for21day/screens/home_screen/body/widgets/animated_list.dart';
import 'package:for21day/screens/home_screen/body/widgets/categories_drop_down_button.dart';
import 'package:for21day/screens/home_screen/body/widgets/empty_icon.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: (context.watch<SearchController>().search)
            ? const BackIcon()
            : const Icon(Icons.done),
        title: (context.watch<SearchController>().search)
            ? null
            : const CategoriesDropDownButton(),
        actions: [
          if (!context.watch<SearchController>().search)
            IconButton(
              onPressed: () {
                context.read<SearchController>().toggleSearch();
                context.read<SearchController>().getNotes();
              },
              icon: const Icon(Icons.search),
            ),
        ],
      ),
      body: (context.watch<SearchController>().search)
          ? ListView(
              children: const [
                SearchTextField(),
                SearchList(),
              ],
            )
          : FutureBuilder(
              future: context.read<NoteController>().getNotes(context),
              builder: (context, _) {
                if (context.watch<NoteController>().notes.isNotEmpty) {
                  return const NotesAnimatedList();
                } else {
                  return const EmptyIcon();
                }
              }),
      floatingActionButton: (!context.watch<SearchController>().search)
          ? SizedBox(
              height: 60,
              width: 60,
              child: FloatingActionButton(
                backgroundColor: Colors.blueGrey.shade800,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => AddTodoScreen())),
                      (route) => false);
                },
                isExtended: true,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add,
                    size: 35,
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
