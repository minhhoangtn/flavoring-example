import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flavoring/presentation/auth/bloc/auth_bloc.dart';
import 'package:flavoring/presentation/common/common_barrel.dart';
import 'package:flavoring/utils/push_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  static Row _buildTitle() {
    return Row(
      children: [
        Text(
          'Taskker',
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
