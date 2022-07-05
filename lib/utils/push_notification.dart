import 'package:flutter_local_notifications/flutter_local_notifications.dart';

AndroidNotificationChannel androidFCMChannel = const AndroidNotificationChannel(
    'notification_channel_testId', 'notification_channel_testName',
    description: 'notification test channel', importance: Importance.max);

AndroidNotificationChannel androidLocalChannel =
    const AndroidNotificationChannel(
        'local_channel_testId', 'local_channel_testName',
        description: 'local test channel', importance: Importance.max);

final FlutterLocalNotificationsPlugin localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> setupPushNotification() async {
  ///Can initialize in main or first screen in app
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await localNotificationsPlugin.initialize(
    initializationSettings,
    // onSelectNotification: selectNotification
    /// => Not work since 4.0 version of lib
  );
}

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  print('$id title: $title, body: $body, payload $payload');
}
