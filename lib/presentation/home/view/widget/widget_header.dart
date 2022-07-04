import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flutter/material.dart';

class WidgetHeader extends StatelessWidget {
  const WidgetHeader({
    Key? key,
    required this.username,
    required this.undoneTaskCount,
  }) : super(key: key);

  final String username;
  final int undoneTaskCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 12, left: 12),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(text: 'Xin chào ', style: AppTextStyle.black(16)),
          TextSpan(
              text: username,
              style: AppTextStyle.orange(18, weight: FontWeight.bold)),
          TextSpan(
              text: ', hiện tại bạn đang có ', style: AppTextStyle.black(16)),
          TextSpan(
              text: undoneTaskCount.toString(),
              style: AppTextStyle.orange(18, weight: FontWeight.bold)),
          TextSpan(
              text: ' Task chưa được hoàn thành!',
              style: AppTextStyle.black(16)),
        ]),
      ),
    );
  }
}
