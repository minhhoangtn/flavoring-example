import 'package:flavoring/presentation/home/home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // home: Navigator(
      //   onPopPage: (Route<dynamic> route, dynamic result) =>
      //       route.didPop(result),
      //   pages: [
      //     MaterialPage(
      //         child: Scaffold(
      //       body: Container(
      //         height: 200,
      //         width: 200,
      //         color: Colors.red,
      //       ),
      //     ))
      //   ],
      // ),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) {
                return const MyHomePage(title: 'Flutter Demo Home Page');
              });
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
              return const MyHomePage(title: 'Flutter Demo Home Page');
            });
      },
    );
  }
}
