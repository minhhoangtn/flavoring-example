import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flutter/material.dart';


class WidgetDialog extends Dialog {
 final  Widget content;
  WidgetDialog(
      {Key? key,
      required this.content
       })
      : super(
    key: key,
    insetPadding: const EdgeInsets.all(24),
    shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 24, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
         content
        ],
      ),
    ),
  );
}
