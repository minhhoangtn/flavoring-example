import 'package:shared_preferences/shared_preferences.dart';

enum SharedPreferenceKey { tokenKey }

class SharedPreferenceHelper {
  static SharedPreferenceHelper? _instance;
  late final SharedPreferences sharedPreferences;

  static SharedPreferenceHelper get instance {
    _instance ??= SharedPreferenceHelper._();
    return _instance!;
  }

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  SharedPreferenceHelper._();

  Future<bool> setString(SharedPreferenceKey key, String value) =>
      sharedPreferences.setString(key.name, value);

  String? getString(SharedPreferenceKey key) =>
      sharedPreferences.getString(key.name);

  Future<bool> removeString(SharedPreferenceKey key) =>
      sharedPreferences.remove(key.name);
}
