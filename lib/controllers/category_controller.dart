// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Todo/controllers/note_controller.dart';
import 'package:Todo/helpers/store_helper.dart';
import 'package:Todo/models/category.dart';
import 'package:Todo/objectbox.g.dart';
import 'package:Todo/variables/colors.dart';
import 'package:provider/provider.dart';

class CategoryController extends ChangeNotifier {
  CategoryController() {
    addDefultCategories();
  }

  Category? selectedCategory;

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  TextEditingController addCategoryController = TextEditingController();

  //* we get categories in 3 sitiuations first in the start of the application
  //* second when we change the category 
  //* third when we open the add note page
  getAllCategories() async {
    _categories = StaticStore.store.box<Category>().getAll();
    if (selectedCategory == null) {
      if (categories.isNotEmpty) {
        selectedCategory = categories.first;
      }
    } else {
      selectedCategory = categories
          .firstWhere((element) => element.id == selectedCategory!.id);
    }
    notifyListeners();
  }

  //? adding category and its statemanagement and validation
  addCateogry(BuildContext context) async {
    if (addCategoryController.text.isNotEmpty) {
      Category category =
          Category(name: addCategoryController.text, addTime: DateTime.now());
      StaticStore.store.box<Category>().put(category);
      categories.add(category);
      selectedCategory = category;
      notifyListeners();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          'Please add the name ',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ));
    }
  }

  removeCategory(Category category) async {
    categories.remove(category);
    StaticStore.store.box<Category>().remove(category.id);
    notifyListeners();
  }
  
  selectCategory(Category category, BuildContext context) {
    getAllCategories();
    selectedCategory =
        categories.firstWhere((element) => element.id == category.id);
    context.read<NoteController>().getNotesFromCategory(context);
    print(category.notes);
    notifyListeners();
  }

  addDefultCategories() {
    List<Category> databaseCategories =
        StaticStore.store.box<Category>().getAll();
    if (!databaseCategories.any((element) =>
        element.name.toLowerCase() == 'all lists' ||
        element.name.toLowerCase() == 'done')) {
      print('always true?');
      categories.add(Category(name: 'All Lists', addTime: DateTime.now()));
      categories.add(Category(name: 'done', addTime: DateTime.now()));
      StaticStore.store.box<Category>().putMany(categories);
    }
    getAllCategories();
  }
}
