import 'dart:io';

import 'package:flutter/material.dart';
import 'package:Todo/controllers/add_todo_controller.dart';
import 'package:Todo/controllers/category_controller.dart';
import 'package:Todo/controllers/note_controller.dart';
import 'package:Todo/controllers/notification_controller.dart';
import 'package:Todo/controllers/search_controller.dart';
import 'package:Todo/helpers/store_helper.dart';
import 'package:Todo/models/category.dart';
import 'package:Todo/models/note.dart';
import 'package:Todo/screens/home_screen/home_screen.dart';
import 'package:Todo/variables/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDirectory = await getApplicationDocumentsDirectory();
  Directory('${appDocDirectory.path}/dir')
      .create(recursive: true)
      .then((Directory directory) {
    // ignore: avoid_print
    print('Path of New Dir: ${directory.path}');
  });
  //? Setting up the local database in an abstract class to access through all the app
  await StaticStore.openStaticStore();
  StaticStore.store.box<Category>().removeAll();
  StaticStore.store.box<Note>().removeAll();
  runApp(const Todo());
}

class Todo extends StatelessWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NotificationController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddTodoController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchController(),
        ),
        ChangeNotifierProvider(
          create: (context) => NoteController(context),
        ),
      ],
      //? Using responsive sizer so we don't miss the context while assigning dynamic sizes
      child: ResponsiveSizer(
        builder: (p0, p1, p2) => MaterialApp(
          darkTheme: ThemeData(
            primaryColor: AppColors.buttonsColor,
            fontFamily: "Oleo Script Swash Caps",
            scaffoldBackgroundColor: AppColors.backgroundColor,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.buttonsColor,
            ),
          ),
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
