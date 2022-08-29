import 'package:Todo/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

abstract class StaticStore {
  static late Store store;
  static openStaticStore() async {
    await getApplicationDocumentsDirectory().then((value) {
      store = Store(getObjectBoxModel(), directory: '${value.path}/objectBox');
    });
  }
}
