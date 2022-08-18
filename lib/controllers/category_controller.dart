import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for21day/helpers/store_helper.dart';
import 'package:for21day/models/category.dart';
import 'package:for21day/objectbox.g.dart';
import 'package:for21day/variables/colors.dart';

class CategoryController extends ChangeNotifier {
  CategoryController() {
    if (StaticStore.store.box<Category>().isEmpty()) {
      addDefultCategories();
    } else {
      getAllCategories();
    }
  }

  Category? selectedCategory;

  List<Category> categories = [];

  TextEditingController addCategoryController = TextEditingController();

  getAllCategories() async {
    categories = StaticStore.store.box<Category>().getAll();
    if (categories.isNotEmpty) {
      selectedCategory = categories.first;
    }
    notifyListeners();
  }

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

  selectCategory(Category category) {
    selectedCategory = category;
    notifyListeners();
  }

  addDefultCategories() {
    categories.add(Category(name: 'All Lists', addTime: DateTime.now()));
    categories.add(Category(name: 'done', addTime: DateTime.now()));

    StaticStore.store.box<Category>().putMany(categories);
  }
}
