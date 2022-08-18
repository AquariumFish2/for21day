import 'dart:io';

import 'package:flutter/material.dart';
import 'package:for21day/controllers/add_todo_controller.dart';
import 'package:for21day/controllers/category_controller.dart';
import 'package:for21day/controllers/note_controller.dart';
import 'package:for21day/controllers/search_controller.dart';
import 'package:for21day/helpers/store_helper.dart';
import 'package:for21day/screens/home_screen/home_screen.dart';
import 'package:for21day/variables/colors.dart';
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
  await StaticStore.openStaticStore();
  runApp(const For21Day());
}

class For21Day extends StatelessWidget {
  const For21Day({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NoteController(),
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
      ],
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
