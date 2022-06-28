import 'package:shared_preferences/shared_preferences.dart';

enum SharedPreferenceKey { tokenKey }

class SharedPreferenceHelper {
  final SharedPreferences instance;
  SharedPreferenceHelper(this.instance);

  Future<bool> setString(SharedPreferenceKey key, String value) =>
      instance.setString(key.name, value);

  String? getString(SharedPreferenceKey key) => instance.getString(key.name);
}
