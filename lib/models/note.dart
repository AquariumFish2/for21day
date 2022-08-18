import 'package:for21day/models/category.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Note {
  int id;
  String data;
  DateTime? addDate;
  DateTime dueDate;
  String? time;
  bool isDone = false;
  ToOne<Category> category = ToOne<Category>();
  Note({
    this.id = 0,
    required this.addDate,
    required this.data,
    required this.dueDate,
    this.time,
  });
}
