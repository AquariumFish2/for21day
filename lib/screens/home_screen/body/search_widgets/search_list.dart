import 'package:flutter/material.dart';
import 'package:for21day/controllers/search_controller.dart';
import 'package:for21day/screens/home_screen/body/widgets/note_view_model.dart';
import 'package:provider/provider.dart';

class SearchList extends StatelessWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchController>(
      builder: (context, searchController, child) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: searchController.searchedNotes.length,
        itemBuilder: (context, index) => NoteViewModel(
          note: searchController.searchedNotes[index],
          index: index,
          onSearchMode: true,
        ),
      ),
    );
  }
}
