import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flavoring/presentation/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final String? route;
  const HomePage({Key? key, this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.whiteFD,
        title: Row(
          children: [
            Text(
              route ?? 'Taskker',
              style: AppTextStyle.black(20, weight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Center(
        child: GestureDetector(
            onTap: () {
              context.read<AuthBloc>().add(const LoggedOut());
              print('log out');
            },
            child: const Text('log out')),
      ),
    );
  }
}
