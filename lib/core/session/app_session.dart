import 'package:flavoring/core/db_helper/shared_preference_helper.dart';

class AppSession {
  static Future<bool> saveAccessToken(String accessToken) =>
      SharedPreferenceHelper.instance
          .setString(SharedPreferenceKey.tokenKey, accessToken);

  static Future<bool> removeAccessToken() => SharedPreferenceHelper.instance
      .removeString(SharedPreferenceKey.tokenKey);

  static String? get accessToken =>
      SharedPreferenceHelper.instance.getString(SharedPreferenceKey.tokenKey);
}
