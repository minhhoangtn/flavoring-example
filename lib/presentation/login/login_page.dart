import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flavoring/data/data_source/local/hive_helper.dart';
import 'package:flavoring/data/data_source/local/local_barrel.dart';
import 'package:flavoring/data/model/entity/user/user_entity.dart';
import 'package:flavoring/data/model/request/auth/login_request.dart';
import 'package:flavoring/data/model/request/auth/register_request.dart';
import 'package:flavoring/data/model/request/task/add_task_request.dart';
import 'package:flavoring/data/repository/repository_barrel.dart';

import 'package:flavoring/presentation/common/common_barrel.dart';
import 'package:flavoring/utils/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../data/model/exception/error_exception.dart';

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
                    onPressed: () async {
                      try {
                        await getIt<TaskRepository>().addTask(AddTaskRequest(
                            title: 'Number02', note: "helo", deadline: 10));
                        final tasks =
                            await getIt<TaskRepository>().fetchListTask();
                        print(tasks);
                      } on ErrorException catch (e) {
                        print(e.errorMessage);
                      }
                      // try {
                      //   await getIt<AuthRepository>().registerAccount(
                      //       RegisterRequest(
                      //           email: 'minhhoang@mail',
                      //           password: 'minhhoang',
                      //           fullName: 'minh hoang nguyen viet'));
                      //   UserEntity entity = await getIt<AuthRepository>().login(
                      //       LoginRequest(
                      //           email: 'minhhoang@mail',
                      //           password: 'minhhoang'));
                      //   print(entity);
                      // } on ErrorException catch (e) {
                      //   print(e.errorMessage);
                      // }
                      // getIt<HiveHelper>().test('helo hive');
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
