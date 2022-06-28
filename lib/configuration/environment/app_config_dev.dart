import 'package:flavoring/configuration/environment/env.dart';

class AppConfigDev extends AppConfig {
  @override
  String get appName => 'Flavoring Dev';

  @override
  String get baseUrl => '';

  @override
  AppEnv get flavor => AppEnv.dev;
}
