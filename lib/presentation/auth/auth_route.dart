import 'package:flavoring/data/repository/auth_repository.dart';
import 'package:flavoring/presentation/auth/register/bloc/register_cubit.dart';
import 'package:flavoring/core/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login/bloc/login_cubit.dart';
import 'login/view/login_page.dart';
import 'register/view/register_page.dart';

class AuthRoute {
  static Widget get login => BlocProvider(
        create: (context) => LoginCubit(getIt<AuthRepository>()),
        child: const LoginPage(),
      );

  static Widget get register => BlocProvider(
        create: (context) => RegisterCubit(getIt<AuthRepository>()),
        child: const RegisterPage(),
      );
}
