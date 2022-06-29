import 'package:flavoring/data/data_source/local/local_barrel.dart';
import 'package:flavoring/utils/di/injection.dart';
import 'package:flutter/material.dart';

class CountDownPage extends StatelessWidget {
  const CountDownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              await getIt<SharedPreferenceHelper>()
                  .setString(SharedPreferenceKey.test, "this is test");
            },
            child: Container(
              height: 100,
              width: 100,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              String? result = getIt<SharedPreferenceHelper>()
                  .getString(SharedPreferenceKey.test);
              print(result ?? "This is null");
            },
            child: Container(
              height: 100,
              width: 100,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
