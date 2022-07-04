import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flavoring/presentation/auth/bloc/auth_bloc.dart';
import 'package:flavoring/presentation/common/common_barrel.dart';
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
          title: Row(
            children: [
              Text(
                'Taskker',
                style: AppTextStyle.orange(30, weight: FontWeight.bold),
              )
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => WidgetDialog(
                          content: Column(
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            'Bạn có chắc chắn muốn đăng xuất?',
                            style: AppTextStyle.black(16),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: WidgetButton(
                                  color: AppColor.whiteFD,
                                  title: 'Hủy bỏ',
                                  textStyle: AppTextStyle.black(14),
                                  borderColor: AppColor.greyMaterial,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: WidgetButton(
                                  color: AppColor.orangeFF,
                                  title: 'Xác nhận',
                                  onPressed: () {
                                    context
                                        .read<AuthBloc>()
                                        .add(const LoggedOut());
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ))),
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
}
