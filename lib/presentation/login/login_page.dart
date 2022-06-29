import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flavoring/data/data_source/local/hive_helper.dart';
import 'package:flavoring/presentation/common/common_barrel.dart';
import 'package:flavoring/utils/di/injection.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
                color: AppColor.orangeFF,
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(100))),
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                const SizedBox(height: 20),
                WidgetTextField(
                  hintText: 'Email',
                ),
                const SizedBox(height: 20),
                WidgetTextField(
                  hintText: 'Password',
                ),
                TextButton(
                    onPressed: () {
                      getIt<HiveHelper>().test('helo hive');
                      // Navigator.of(context).pushNamed('/home');
                    },
                    child: const Text('Go to home!'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
