import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flavoring/core/extension/extension_barrel.dart';

import 'widget_text_field.dart';

class WidgetDatePicker extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final DateTime? initialDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final CupertinoDatePickerMode? pickerMode;
  const WidgetDatePicker(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.initialDate,
      this.maximumDate,
      this.minimumDate,
      this.pickerMode,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetTextField(
      readOnly: true,
      suffixIcon: SizedBox(
          height: 20,
          width: 20,
          child: Icon(
            Icons.calendar_today_sharp,
            color: AppColor.greyMaterial,
          )),
      hintText: hintText,
      controller: controller,
      validator: validator,
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => AppDatePickerWidget(
                title: '',
                minimumDate: minimumDate,
                initialDate: initialDate,
                maximumDate: maximumDate,
                pickerMode: pickerMode,
                onDateTimeSelected: (value) {
                  controller.text = value.toDisplayString();
                }));
      },
    );
  }
}

class AppDatePickerWidget extends StatefulWidget {
  final CupertinoDatePickerMode? pickerMode;
  final String title;
  final DateTime? initialDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final Function(DateTime dateTime) onDateTimeSelected;
  const AppDatePickerWidget({
    Key? key,
    this.pickerMode,
    required this.title,
    this.initialDate,
    this.minimumDate,
    this.maximumDate,
    required this.onDateTimeSelected,
  }) : super(key: key);

  @override
  State<AppDatePickerWidget> createState() => _AppDatePickerWidgetState();
}

class _AppDatePickerWidgetState extends State<AppDatePickerWidget> {
  late DateTime selectedDateTime;

  @override
  void initState() {
    selectedDateTime = widget.initialDate ?? DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
      height: 250,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Hủy',
                    style: AppTextStyle.black(16),
                  ),
                ),
                Text(
                  widget.title,
                  style: AppTextStyle.black(18, weight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {
                    widget.onDateTimeSelected(selectedDateTime);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Chọn',
                    style: AppTextStyle.orange(17, weight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: AppColor.greyCF,
          ),
          Expanded(
            child: CupertinoDatePicker(
              use24hFormat: true,
              initialDateTime: widget.initialDate,
              minimumDate: widget.minimumDate,
              maximumDate: widget.maximumDate,
              mode: widget.pickerMode ?? CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newTime) {
                setState(() {
                  selectedDateTime = newTime;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
