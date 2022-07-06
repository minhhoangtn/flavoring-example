import 'package:flavoring/configuration/environment/env.dart';
import 'package:flavoring/core/routing/app_router.dart';

import 'package:flavoring/presentation/app.dart';
import 'package:flavoring/utils/di/injection.dart';
import 'package:flavoring/utils/push_notification.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:timezone/data/latest_all.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Firebase
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  ///Injection
  await setupInjection(AppEnv.dev);

  ///Local notification
  tz.initializeTimeZones();
  await setupPushNotification();
  final notificationAppLaunchDetails =
      await localNotificationsPlugin.getNotificationAppLaunchDetails();
  String initialRoute = RouteDefine.root;
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    initialRoute = RouteDefine.login;
  }

  runApp(MyApp(initialRoute: initialRoute));
}
