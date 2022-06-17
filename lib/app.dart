import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const methodChannel = MethodChannel('com.flavoring/test');
  int _counter = 0;

  Future<void> getLocationDescription() async {
    String description = "";
    try {
      description = await methodChannel.invokeMethod('getMyLocation', 'hello');
    } on PlatformException catch (e) {
      description = "failed due to $e";
    }
    print(description);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
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
