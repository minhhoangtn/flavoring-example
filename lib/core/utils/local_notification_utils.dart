import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

typedef OnTapNotification = void Function(String? payload);

final FlutterLocalNotificationsPlugin localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class LocalNotificationUtils {
  static Future<void> scheduleNotification(
      {required int id,
      required int epocTime,
      String? title,
      String? body,
      String? payload}) async {
    localNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.fromMillisecondsSinceEpoch(
            tz.getLocation('Etc/GMT+8'), epocTime),
        NotificationDetails(
            android: AndroidNotificationDetails(
                androidLocalChannel.id, androidLocalChannel.name,
                channelDescription: androidLocalChannel.description,
                importance: Importance.max)),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static Future<void> initialize(
      {required OnTapNotification onTapNotification}) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await localNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onTapNotification);
  }

  static const androidLocalChannel = AndroidNotificationChannel(
      'local_channel_testId', 'local_channel_testName',
      description: 'local test channel', importance: Importance.max);

  static const androidFCMChannel = AndroidNotificationChannel(
      'notification_channel_testId', 'notification_channel_testName',
      description: 'notification test channel', importance: Importance.max);
}

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {}
