import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flavoring/presentation/auth/bloc/auth_bloc.dart';
import 'package:flavoring/presentation/home/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/home_widget_barrel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit cubit;
  late String userId;

  @override
  void initState() {
    cubit = context.read<HomeCubit>();
    userId = (context.read<AuthBloc>().state as Authenticated).userInfo.id;
    super.initState();
    cubit.fetchList(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        context: context,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 1,
            color: AppColor.greyCF,
          ),
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                switch (state.status) {
                  case ListStatus.success:
                    return ListView.builder(
                      itemBuilder: (_, index) => WidgetTaskItem(
                        key: UniqueKey(),
                        item: state.tasks[index],
                        onPressed: () =>
                            cubit.deleteTask(state.tasks[index].id),
                        onChangeStatus: () =>
                            cubit.changeTaskStatus(state.tasks[index].id),
                      ),
                      itemCount: state.tasks.length,
                    );
                  case ListStatus.loading:
                    return const Center(child: CircularProgressIndicator());
                  case ListStatus.failure:
                    return const Center(child: Text('error'));
                }
              },
            ),
          ),
          WidgetAddTask(cubit: cubit, userId: userId)
        ],
      ),
    );
  }
}
