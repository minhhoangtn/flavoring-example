import 'dart:async';

import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacementNamed('/login'));
    return Scaffold(
      backgroundColor: AppColor.orangeFF,
      body: Center(
          child: Text(
        'Todoist',
        style: AppTextStyle.white(50, weight: FontWeight.bold),
      )),
    );
  }
}
