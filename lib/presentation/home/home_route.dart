import 'package:flavoring/data/repository/repository_barrel.dart';
import 'package:flavoring/presentation/home/bloc/home_cubit.dart';
import 'package:flavoring/presentation/home/view/home_page.dart';
import 'package:flavoring/core/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeRoute {
  static Widget get route => BlocProvider(
        create: (context) => HomeCubit(getIt<TaskRepository>()),
        child: const HomePage(),
      );
}
