import 'dart:convert';

import 'package:flavoring/configuration/style/app_theme.dart';
import 'package:flavoring/core/utils/utils_barrel.dart';
import 'package:flavoring/configuration/routing/app_router.dart';
import 'package:flavoring/data/model/entity/task/task_entity.dart';
import 'package:flavoring/data/repository/auth_repository.dart';
import 'package:flavoring/core/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'auth/bloc/auth_bloc.dart';

class MyApp extends StatefulWidget {
  final NotificationAppLaunchDetails? notificationDetail;
  const MyApp({Key? key, this.notificationDetail}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // AppTheme appTheme = getIt<AppTheme>();
  AppTheme appTheme = AppTheme(CustomTheme.light);
  @override
  void initState() {
    super.initState();
    appTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    appTheme.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(getIt<AuthRepository>()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        navigatorKey: AppNavigator.rootKey,
        theme: appTheme.themeData,
        onGenerateRoute: AppRoute.generateRoute,
        builder: (context, child) {
          return BlocListener<AuthBloc, AuthState>(
              listener: (context, state) async {
                if (state is Unauthenticated) {
                  AppNavigator.currentState!.pushNamedAndRemoveUntil(
                      RouteDefine.login, (route) => false);
                } else if (state is Authenticated) {
                  await LocalNotificationUtils.initialize(
                      onTapNotification: _handleTaskNotification);

                  AppNavigator.currentState!.pushNamedAndRemoveUntil(
                      RouteDefine.home, (route) => false);

                  if (widget.notificationDetail?.didNotificationLaunchApp ==
                      true) {
                    final payload = widget.notificationDetail!.payload;
                    _handleTaskNotification(payload);
                  }
                }
              },
              child: GestureDetector(
                  onTap: () => KeyboardUtils.dismiss(), child: child!));
        },
      ),
    );
  }

  _handleTaskNotification(String? payload) {
    if (payload != null) {
      try {
        final task = TaskEntity.fromJson(jsonDecode(payload));
        AppNavigator.currentState!
            .pushNamed(RouteDefine.taskDetail, arguments: task);
      } catch (_) {}
    }
  }
}

//
// onGenerateRoute: (RouteSettings settings) {
// Widget? page;
// switch (settings.name) {
// case '/':
// page = const SplashPage();
// break;
// case '/home':
// page = const HomePage();
// break;
// case '/notification':
// page = const MyHomePage(title: 'demo');
// break;
// case '/login':
// page = const LoginPage();
// break;
// }
//
// ///Testing for Android Deeplink
// if (settings.name == '/testing?id=10') {
// page = Scaffold(
// body: Center(
// child: Text(
// 'Success with param: 10 uri: and setting.name${settings.name}'),
// ));
// }
// return MaterialPageRoute(
// settings: settings,
// builder: (context) {
// return page ??
// HomePage(
// route: settings.name ?? "no route",
// );
// });
// },
