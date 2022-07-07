import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flutter/material.dart';

import 'common_barrel.dart';

class DialogUtils {
  static Future<bool> showConfirmDialog(
      BuildContext context, String title) async {
    final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => WidgetDialog(
                content: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  title,
                  style: AppTextStyle.black(16),
                  textAlign: TextAlign.center,
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
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: WidgetButton(
                        color: AppColor.orangeFF,
                        title: 'Xác nhận',
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ),
                  ],
                )
              ],
            )));
    return confirm ?? false;
  }
}

class WidgetDialog extends Dialog {
  final Widget content;
  WidgetDialog({Key? key, required this.content})
      : super(
          key: key,
          insetPadding: const EdgeInsets.all(24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 16, bottom: 24, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [content],
            ),
          ),
        );
}
