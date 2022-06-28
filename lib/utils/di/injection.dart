import 'package:dio/dio.dart';
import 'package:flavoring/configuration/environment/env.dart';
import 'package:flavoring/configuration/style/app_theme.dart';
import 'package:flavoring/data/data_source/local/local_barrel.dart';
import 'package:flavoring/data/data_source/remote/remote_barrel.dart';

import 'package:flavoring/data/repository/repository_barrel.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.I;

Future<void> setupInjection(AppEnv flavor) async {
  _registerAppConfig(flavor);
  _registerNetworkComponent();
  await _registerLocalStorage();
  _registerRepository();
}

void _registerNetworkComponent() {
  Dio dio = Dio(
      BaseOptions(baseUrl: getIt<AppConfig>().baseUrl, connectTimeout: 10000));
  getIt.registerSingleton<Dio>(dio);

  getIt.registerSingleton<AuthService>(
      AuthService(dio, baseUrl: dio.options.baseUrl));
}

void _registerRepository() {
  getIt.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(getIt<AuthService>()));
}

Future<void> _registerLocalStorage() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  getIt.registerSingleton<SharedPreferenceHelper>(
      SharedPreferenceHelper(getIt<SharedPreferences>()));
}

void _registerAppConfig(AppEnv flavor) {
  switch (flavor) {
    case AppEnv.dev:
      getIt.registerSingleton<AppConfig>(AppConfigDev());
      break;
    case AppEnv.staging:
      getIt.registerSingleton<AppConfig>(AppConfigStaging());
      break;
    case AppEnv.prod:
      getIt.registerSingleton<AppConfig>(AppConfigProduct());
      break;
  }

  getIt.registerSingleton<AppTheme>(AppTheme(CustomTheme.light));
}
