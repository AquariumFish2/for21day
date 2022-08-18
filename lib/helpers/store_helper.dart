import 'package:for21day/objectbox.g.dart';

abstract class StaticStore {
  static late Store store;
  static openStaticStore() async {
    store = await openStore();
  }
}
