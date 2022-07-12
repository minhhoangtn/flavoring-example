import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flavoring/presentation/auth/bloc/auth_bloc.dart';
import 'package:flavoring/presentation/common/common_barrel.dart';
import 'package:flavoring/presentation/home/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetAppBar extends AppBar {
  final BuildContext context;

  WidgetAppBar({Key? key, required this.context})
      : super(
          key: key,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.whiteFD,
          title: _buildTitle(),
          bottom: _buildDivider(),
          actions: [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return PopupMenuButton<FilterStatus>(
                    icon: Icon(Icons.filter_alt_outlined,
                        color: AppColor.orangeE6),
                    onSelected: (item) {
                      if (state.filter == item) {
                        context.read<HomeCubit>().filterTasks(FilterStatus.all);
                      } else {
                        context.read<HomeCubit>().filterTasks(item);
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<FilterStatus>>[
                          _buildFilterOption(FilterStatus.byDone,
                              isSelected: state.filter == FilterStatus.byDone),
                          _buildFilterOption(FilterStatus.byUndone,
                              isSelected:
                                  state.filter == FilterStatus.byUndone),
                          _buildFilterOption(FilterStatus.byDueDate,
                              isSelected:
                                  state.filter == FilterStatus.byDueDate),
                        ]);
              },
            ),
            GestureDetector(
              onTap: () async {
                final confirm = await DialogUtils.showConfirmDialog(
                    context, 'Bạn có chắc chắn muốn đăng xuất');
                if (confirm) context.read<AuthBloc>().add(const LoggedOut());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.exit_to_app,
                  color: AppColor.orangeE6,
                ),
              ),
            )
          ],
        );

  static _buildFilterOption(FilterStatus value, {required bool isSelected}) {
    return PopupMenuItem<FilterStatus>(
      value: value,
      child: Row(
        children: [
          SizedBox(
              height: 20,
              width: 20,
              child: Checkbox(value: isSelected, onChanged: (value) {})),
          const SizedBox(width: 10),
          Text('Lọc theo ${value.name}')
        ],
      ),
    );
  }

  static Row _buildTitle() {
    return Row(
      children: [
        Text(
          'Todoist',
          style: AppTextStyle.orange(30, weight: FontWeight.bold),
        )
      ],
    );
  }

  static PreferredSize _buildDivider() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: Container(
        width: double.infinity,
        height: 1,
        color: AppColor.greyCF,
      ),
    );
  }
}
