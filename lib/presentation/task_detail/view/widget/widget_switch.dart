import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flutter/material.dart';

class WidgetSwitch extends StatelessWidget {
  final String title;
  final bool value;
  final VoidCallback onTap;
  const WidgetSwitch(
      {Key? key, required this.title, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyle.black(14),
        ),
        Switch(
            value: value,
            onChanged: (value) {
              onTap.call();
            }),
      ],
    );
  }
}
