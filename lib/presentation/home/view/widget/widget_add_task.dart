import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flavoring/core/core.dart';
import 'package:flavoring/presentation/common/common_barrel.dart';
import 'package:flavoring/presentation/home/bloc/home_cubit.dart';
import 'package:flavoring/utils/keyboard_utils.dart';
import 'package:flavoring/utils/validator_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetAddTask extends StatelessWidget {
  final HomeCubit cubit;
  final String userId;
  const WidgetAddTask({Key? key, required this.cubit, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(color: AppColor.whiteFD, boxShadow: [
        BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10)
      ]),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) =>
                  WidgetAddTaskDialog(cubit: cubit, userId: userId));
        },
        child: Row(
          children: [
            Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                  color: AppColor.orangeE6, shape: BoxShape.circle),
              child: Icon(
                Icons.add,
                color: AppColor.whiteFD,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Thêm công việc mới',
              style: AppTextStyle.orange(16, weight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

class WidgetAddTaskDialog extends StatefulWidget {
  final HomeCubit cubit;
  final String userId;
  const WidgetAddTaskDialog(
      {Key? key, required this.cubit, required this.userId})
      : super(key: key);

  @override
  State<WidgetAddTaskDialog> createState() => _WidgetAddTaskDialogState();
}

class _WidgetAddTaskDialogState extends State<WidgetAddTaskDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WidgetDialog(
        content: Form(
      key: _formKey,
      child: Column(
        children: [
          WidgetTextField(
            hintText: 'Mục tiêu',
            controller: titleController,
            validator: (value) {
              if (ValidatorUtils.validateEmpty(value)) {
                return "Nhập vào mục tiêu";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          WidgetDatePicker(
            minimumDate: DateTime.now(),
            hintText: 'Hạn chót',
            controller: deadlineController,
            pickerMode: CupertinoDatePickerMode.dateAndTime,
            validator: (value) {
              if (ValidatorUtils.validateEmpty(value)) {
                return 'Chọn hạn chót';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          WidgetTextField(
            hintText: 'Ghi chú',
            maxLine: 3,
            controller: noteController,
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
                    if (_formKey.currentState!.validate()) {
                      KeyboardUtils.dismiss();
                      widget.cubit.addTask(
                          titleController.text,
                          noteController.text,
                          deadlineController.text.toDateTime(),
                          widget.userId);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
