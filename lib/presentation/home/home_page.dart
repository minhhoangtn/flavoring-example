import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flavoring/configuration/environment/env.dart';
import 'package:flavoring/data/data_source/local/shared_preference_helper.dart';
import 'package:flavoring/main_DEV.dart';
import 'package:flavoring/utils/di/injection.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../count-down/count_down_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const methodChannel = MethodChannel('com.flavoring/test');
  late final String? fcmToken;
  String? _fcmTitle;
  String? _fcmBody;

  Future<void> getLocationDescription() async {
    // String description = "";
    // try {
    //   description = await methodChannel.invokeMethod('getMyLocation', 'hello');
    // } on PlatformException catch (e) {
    //   description = "failed due to $e";
    // }

    // print(description);
  }

  Future<void> configureCloudMessagingNotification() async {
    /// Only need for IOS
    final NotificationSettings userPermission =
        await FirebaseMessaging.instance.requestPermission();
    print(
        'User notification permission: ${userPermission.authorizationStatus}');

    /// Configure for Android high priority Notification Channel
    await localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidCustomChannel);

    fcmListenHandler();

    fcmToken = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $fcmToken');
  }

  void fcmListenHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      setState(() {
        _fcmTitle = message.notification?.title;
        _fcmBody = message.notification?.body;
      });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      setState(() {
        _fcmTitle = message.notification?.title;
        _fcmBody = message.notification?.body;
      });
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.onTokenRefresh.listen((String newToken) {
      fcmToken = newToken;
      print('New FCM Token: $fcmToken');
    });
  }

  @override
  void initState() {
    super.initState();
    configureCloudMessagingNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'This is an example project used for testing feature',
            ),
            Text(
              _fcmTitle ?? "Currently, There is no fcm messages",
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Message Body: $_fcmBody',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CountDownPage()));
              },
              child: const Icon(Icons.navigate_next),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getLocationDescription,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
