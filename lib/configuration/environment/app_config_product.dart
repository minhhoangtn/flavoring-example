import 'package:flavoring/configuration/environment/env.dart';

class AppConfigProduct extends AppConfig {
  @override
  String get appName => 'Flavoring Prod';

  @override
  // TODO: implement baseUrl
  String get baseUrl => throw UnimplementedError();

  @override
  // TODO: implement flavor
  AppEnv get flavor => AppEnv.prod;
}
