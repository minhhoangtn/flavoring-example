import 'package:flavoring/data/model/entity/user/user_entity.dart';
import 'package:flavoring/presentation/auth/bloc/auth_bloc.dart';
import 'package:flavoring/presentation/home/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/widget_barrel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit cubit;
  late UserEntity user;

  @override
  void initState() {
    cubit = context.read<HomeCubit>();
    user = (context.read<AuthBloc>().state as Authenticated).userInfo;
    super.initState();
    cubit.fetchList(user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        context: context,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                switch (state.status) {
                  case ListStatus.success:
                    return state.tasks.isEmpty
                        ? const Center(
                            child: Text('Bạn đang không có task nào'),
                          )
                        : ListView.separated(
                            reverse: true,
                            separatorBuilder: (_, index) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              if (index == state.tasks.length) {
                                return Builder(builder: (context) {
                                  final undoneTasks = state.tasks
                                      .where((element) => !element.isDone)
                                      .toList();
                                  return WidgetHeader(
                                    username: user.fullName,
                                    undoneTaskCount: undoneTasks.length,
                                  );
                                });
                              } else {
                                final task = state.tasks[index];
                                return WidgetTaskItem(
                                  item: task,
                                  onPressed: () => cubit.deleteTask(task.id),
                                  onChangeStatus: () =>
                                      cubit.changeTaskStatus(task.id),
                                  onItemChanged: () => cubit.fetchList(user.id),
                                );
                              }
                            },
                            itemCount: state.tasks.length + 1,
                          );
                  case ListStatus.loading:
                    return const Center(child: CircularProgressIndicator());
                  case ListStatus.failure:
                    return const Center(child: Text('error'));
                }
              },
            ),
          ),
          WidgetAddTask(cubit: cubit, userId: user.id)
        ],
      ),
    );
  }
}
