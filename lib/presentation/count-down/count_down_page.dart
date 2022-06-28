import 'package:flavoring/configuration/style/app_theme.dart';
import 'package:flavoring/utils/di/injection.dart';
import 'package:flutter/material.dart';

class CountDownPage extends StatelessWidget {
  const CountDownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () async {
          getIt<AppTheme>().changeTheme(CustomTheme.dark);
          await Future.delayed(const Duration(seconds: 3));
          getIt<AppTheme>().changeTheme(CustomTheme.light);
        },
        child: Container(
          height: 100,
          width: 100,
          color: Colors.red,
        ),
      ),
    );
  }
}
