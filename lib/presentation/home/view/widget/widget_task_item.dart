import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flavoring/core/core.dart';
import 'package:flavoring/data/model/entity/task/task_entity.dart';
import 'package:flutter/material.dart';

class WidgetTaskItem extends StatelessWidget {
  final TaskEntity item;
  final VoidCallback onPressed;
  final VoidCallback onChangeStatus;
  const WidgetTaskItem(
      {Key? key,
      required this.item,
      required this.onPressed,
      required this.onChangeStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: GestureDetector(
            onTap: onPressed,
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
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 1,
                  width: double.infinity,
                  color: AppColor.greyCF,
                ),
              ],
            ),
          ),
        )
      ],
    );
    ;
  }
}
