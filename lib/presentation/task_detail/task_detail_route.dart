import 'package:flavoring/data/model/entity/task/task_entity.dart';
import 'package:flavoring/data/repository/repository_barrel.dart';
import 'package:flavoring/presentation/task_detail/bloc/task_detail_cubit.dart';
import 'package:flavoring/presentation/task_detail/view/task_detail_page.dart';
import 'package:flavoring/utils/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskDetailRoute {
  static Widget get route => Builder(builder: (context) {
        final param = ModalRoute.of(context)!.settings.arguments as TaskEntity;
        return BlocProvider(
          create: (context) => TaskDetailCubit(getIt<TaskRepository>()),
          child: TaskDetailPage(
            task: param,
          ),
        );
      });
}
