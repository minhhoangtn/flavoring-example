import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flavoring/presentation/common/common_barrel.dart';
import 'package:flavoring/presentation/task_detail/bloc/task_detail_cubit.dart';
import 'package:flavoring/core/utils/keyboard_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetAppBar extends AppBar {
  final BuildContext context;
  WidgetAppBar({Key? key, required this.context})
      : super(
          key: key,
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColor.whiteFD,
          elevation: 0,
          leading: Container(
            padding: const EdgeInsets.only(left: 10),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () async {
                KeyboardUtils.dismiss();
                final result =
                    context.read<TaskDetailCubit>().checkIfStatusChange();
                if (result) {
                  final confirm = await DialogUtils.showConfirmDialog(
                      context, 'Bạn có chắc chắn muốn loại bỏ các thay đổi?');
                  if (confirm == true) Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                'Hủy bỏ',
                style: AppTextStyle.orange(14, weight: FontWeight.w500),
              ),
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () async {
                  if (!context.read<TaskDetailCubit>().checkIfStatusChange()) {
                    return;
                  }
                  final result =
                      await context.read<TaskDetailCubit>().updateTask();
                  if (result) {
                    print('update');
                    Navigator.of(context).pop(true);
                  } else {
                    print('can not update');
                  }
                },
                child: Text(
                  'Chấp thuận',
                  style: AppTextStyle.orange(14, weight: FontWeight.w500),
                ),
              ),
            ),
          ],
          title: Text(
            'Chi tiết task',
            style: AppTextStyle.black(18, weight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              width: double.infinity,
              height: 1,
              color: AppColor.greyCF,
            ),
          ),
        );
}
