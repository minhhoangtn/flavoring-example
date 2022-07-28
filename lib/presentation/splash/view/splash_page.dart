import 'dart:async';

import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flavoring/presentation/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String title = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      const fullyTitle = 'Todoist';
      await animatedTitle(fullyTitle);
      context.read<AuthBloc>().add(const AppStarted());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.orangeFF,
      body: Center(
          child: Text(
        title,
        style: AppTextStyle.white(50, weight: FontWeight.bold),
      )),
    );
  }

  Future<void> animatedTitle(String fullyTitle) async {
    for (int i = 0; i < fullyTitle.length; i++) {
      title += fullyTitle[i];
      setState(() {});
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }
}
