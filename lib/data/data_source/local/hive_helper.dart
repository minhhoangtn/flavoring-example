import 'package:hive/hive.dart';

enum HiveDB { user, task }

class HiveHelper {
  static HiveHelper? _instance;

  static HiveHelper get instance {
    _instance ??= HiveHelper._();
    return _instance!;
  }

  Future<bool> deleteItem<T>(HiveDB db, String id) async {
    try {
      await Hive.box<T>(db.name).delete(id);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> addItem<T>(HiveDB db, String id, T value) async {
    try {
      await Hive.box<T>(db.name).put(id, value);
      return true;
    } catch (_) {
      return false;
    }
  }

  T? getItem<T>(HiveDB db, String id) {
    try {
      return Hive.box<T>(db.name).get(id);
    } catch (_) {
      return null;
    }
  }

  List<T>? getListItem<T>(HiveDB db) {
    try {
      return Hive.box<T>(db.name).values.toList();
    } catch (_) {
      return null;
    }
  }

  Future<void> init() async {
    await Hive.openBox<String>(HiveDB.user.name);
    await Hive.openBox<String>(HiveDB.task.name);
  }

  HiveHelper._();
}
