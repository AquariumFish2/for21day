import 'package:flutter/material.dart';
import 'package:Todo/controllers/search_controller.dart';
import 'package:provider/provider.dart';

class BackIcon extends StatelessWidget {
  const BackIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<SearchController>().toggleSearch(),
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
    );
  }
}
