import 'package:flavoring/configuration/environment/env.dart';
import 'package:flavoring/configuration/routing/app_router.dart';
import 'package:flavoring/presentation/app.dart';
import 'package:flavoring/utils/di/injection.dart';
import 'package:flavoring/utils/push_notification.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  final notificationAppLaunchDetails =
      await localNotificationsPlugin.getNotificationAppLaunchDetails();
  String initialRoute = RouteDefine.root;
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    initialRoute = RouteDefine.login;
  }
  await setupInjection(AppEnv.dev);
  await setupPushNotification();
  runApp(MyApp(initialRoute: initialRoute));
}
