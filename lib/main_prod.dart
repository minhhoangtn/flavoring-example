import 'package:flavoring/configuration/environment/env.dart';
import 'package:flavoring/presentation/app.dart';
import 'package:flavoring/core/injection.dart';

import 'package:flavoring/core/utils/utils_barrel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:timezone/data/latest_all.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  await setupInjection(AppEnv.prod);

  final notificationAppLaunch =
      await localNotificationsPlugin.getNotificationAppLaunchDetails();

  runApp(MyApp(notificationDetail: notificationAppLaunch));
}
