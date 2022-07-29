import 'package:flavoring/configuration/environment/env.dart';

class AppConfigProduct extends AppConfig {
  @override
  String get appName => 'Flavoring Prod';

  @override
  String get baseUrl => '';

  @override
  AppEnv get flavor => AppEnv.prod;
}
