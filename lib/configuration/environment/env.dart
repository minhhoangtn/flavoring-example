export 'app_config_dev.dart';
export 'app_config_product.dart';
export 'app_config_staging.dart';

enum AppEnv { dev, staging, prod }

abstract class AppConfig {
  String get baseUrl;

  AppEnv get flavor;

  String get appName;
}
