import 'package:flavoring/presentation/auth/auth_route.dart';
import 'package:flavoring/presentation/home/home_route.dart';

import 'package:flavoring/presentation/splash/splash_route.dart';
import 'package:flavoring/presentation/task_detail/task_detail_route.dart';
import 'package:flutter/material.dart';

class RouteDefine {
  static String root = '/';

  static String home = 'home';

  ///Auth
  static String login = 'login';
  static String register = 'register';

  ///Task
  static String taskDetail = 'taskDetail';
}

class AppRoute {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    final routes = <String, WidgetBuilder>{
      RouteDefine.root: (_) => SplashRoute.route,
      RouteDefine.home: (_) => HomeRoute.route,

      ///Auth
      RouteDefine.login: (_) => AuthRoute.login,
      RouteDefine.register: (_) => AuthRoute.register,

      ///Task
      RouteDefine.taskDetail: (_) => TaskDetailRoute.route,
    };

    final routeBuilder = routes[settings.name];

    return MaterialPageRoute(
      builder: (context) => routeBuilder!(context),
      settings: settings,
    );
  }
}
