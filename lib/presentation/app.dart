import 'package:flavoring/configuration/style/app_theme.dart';
import 'package:flavoring/presentation/home/home_page.dart';

import 'package:flavoring/presentation/login/login_page.dart';
import 'package:flavoring/presentation/splash/splash_page.dart';
import 'package:flavoring/utils/di/injection.dart';
import 'package:flutter/material.dart';

import 'notification/home_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTheme appTheme = getIt<AppTheme>();
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme.themeData,
      onGenerateRoute: (RouteSettings settings) {
        Widget? page;
        switch (settings.name) {
          case '/':
            page = const SplashPage();
            break;
          case '/home':
            page = const HomePage();
            break;
          case '/notification':
            page = const MyHomePage(title: 'demo');
            break;
          case '/login':
            page = const LoginPage();
            break;
        }

        ///Testing for Android applink
        var uri = Uri.parse(settings.name!);
        if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'testing') {
          final String param = uri.pathSegments[1];
          return MaterialPageRoute(
              settings: settings,
              builder: (context) {
                return Scaffold(
                  body: Center(
                    child: Text('Success with param: $param'),
                  ),
                );
              });
        }
        return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              return page ?? const SplashPage();
            });
      },
    );
  }
}
