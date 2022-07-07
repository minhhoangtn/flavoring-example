import 'package:dio/dio.dart';
import 'package:flavoring/configuration/environment/env.dart';

import 'package:flavoring/core/db_helper/db_helper_barrel.dart';
import 'package:flavoring/data/data_source/local/local_barrel.dart';

import 'package:flavoring/data/data_source/remote/remote_barrel.dart';

import 'package:flavoring/data/repository/repository_barrel.dart';

import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

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

  getIt.registerFactory<AuthService>(
      () => AuthService(dio, baseUrl: dio.options.baseUrl));
}

void _registerRepository() {
  getIt.registerFactory<AuthRepository>(() => AuthRepositoryImpl(getIt()));

  getIt.registerFactory<TaskRepository>(() => TaskRepositoryImpl(getIt()));
}

Future<void> _registerLocalStorage() async {
  await SharedPreferenceHelper.instance.init();

  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);

  await HiveHelper.instance.init();

  getIt.registerFactory<UserDAO>(() => UserDAOImpl());

  getIt.registerFactory<TaskDAO>(() => TaskDAOImpl());
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

  // getIt.registerSingleton<AppTheme>(AppTheme(CustomTheme.light));
}
