import 'package:flavoring/configuration/routing/app_router.dart';
import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flavoring/core/extension/extension_barrel.dart';
import 'package:flavoring/data/model/entity/task/task_entity.dart';
import 'package:flavoring/presentation/common/common_barrel.dart';

import 'package:flutter/material.dart';

class WidgetTaskItem extends StatelessWidget {
  final TaskEntity item;
  final VoidCallback onDeletedConfirm;
  final VoidCallback onChangeStatus;
  final VoidCallback onItemChanged;
  const WidgetTaskItem(
      {Key? key,
      required this.item,
      required this.onDeletedConfirm,
      required this.onItemChanged,
      required this.onChangeStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: _buildDismissBackground(),
      direction: DismissDirection.endToStart,
      key: UniqueKey(),
      confirmDismiss: (direction) async {
        final isDismiss = await _showConfirmDialog(context);
        return isDismiss;
      },
      onDismissed: (direction) => onDeletedConfirm.call(),
      child: InkWell(
        onTap: () async {
          final isItemUpdated = await Navigator.of(context)
              .pushNamed(RouteDefine.taskDetail, arguments: item);
          if (isItemUpdated == true) {
            onItemChanged.call();
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.scale(
              scale: 1.2,
              child: Radio(
                  value: true,
                  groupValue: item.isDone,
                  toggleable: true,
                  onChanged: (value) {
                    onChangeStatus();
                  }),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    item.title,
                    style: AppTextStyle.black(18),
                  ),
                  const SizedBox(height: 5),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(text: 'Deadline: ', style: AppTextStyle.grey(16)),
                    TextSpan(
                        text: item.deadline.fromEpoch().toDisplayString(),
                        style: AppTextStyle.orange(16))
                  ])),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 1,
                    width: double.infinity,
                    color: AppColor.greyCF,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    ;
  }

  _buildDismissBackground() {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.only(right: 20),
      alignment: Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  _showConfirmDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (context) => WidgetDialog(
                content: Column(
              children: [
                Text(
                  'Bạn có chắc chắn muốn xóa?',
                  style: AppTextStyle.black(16),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(false),
                      child: Text(
                        'Không',
                        style: AppTextStyle.grey(16),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(true),
                      child: Text(
                        'Có',
                        style: AppTextStyle.orange(16),
                      ),
                    )
                  ],
                )
              ],
            )));
  }
}
