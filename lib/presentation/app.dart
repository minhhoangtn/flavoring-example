import 'package:flavoring/configuration/style/app_theme.dart';
import 'package:flavoring/data/repository/auth_repository.dart';

import 'package:flavoring/utils/di/injection.dart';
import 'package:flavoring/utils/keyboard_utils.dart';
import 'package:flavoring/utils/routing/app_navigator.dart';
import 'package:flavoring/utils/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/bloc/auth_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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
        navigatorKey: AppNavigator.rootKey,
        theme: appTheme.themeData,
        onGenerateRoute: AppRoute.generateRoute,
        builder: (context, child) {
          return BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Unauthenticated) {
                  AppNavigator.currentState!.pushNamedAndRemoveUntil(
                      RouteDefine.login, (route) => false);
                } else if (state is Authenticated) {
                  AppNavigator.currentState!.pushNamedAndRemoveUntil(
                      RouteDefine.home, (route) => false);
                }
              },
              child: GestureDetector(
                  onTap: () => KeyboardUtils.dismiss(), child: child!));
        },
      ),
    );
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
