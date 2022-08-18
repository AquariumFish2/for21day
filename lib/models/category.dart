import 'package:for21day/models/note.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Category {
  int id;
  String name;
  DateTime addTime;
  @Backlink()
  var notes = ToMany<Note>();
  Category({
    this.id=0,
    required this.name,
    required this.addTime,
  });
}
