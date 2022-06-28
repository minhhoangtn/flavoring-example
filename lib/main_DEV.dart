import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flavoring/configuration/environment/env.dart';
import 'package:flavoring/presentation/app.dart';
import 'package:flavoring/utils/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  await setupInjection(AppEnv.dev);
  runApp(const MyApp());
}

AndroidNotificationChannel androidCustomChannel =
    const AndroidNotificationChannel(
        'notification_channel_testId', 'notification_channel_testName',
        importance: Importance.max);

final FlutterLocalNotificationsPlugin localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
