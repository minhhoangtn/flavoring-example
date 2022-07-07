import 'package:another_flushbar/flushbar.dart';
import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flavoring/core/routing/app_navigator.dart';
import 'package:flutter/material.dart';

class WidgetSnackBar {
  static void showSuccess(String message,
      {FlushbarPosition position = FlushbarPosition.TOP, EdgeInsets? margin}) {
    Flushbar(
      icon: Icon(
        Icons.check,
        color: Colors.green.shade700,
      ),
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            message,
            style: AppTextStyle.black(14, weight: FontWeight.w600),
          ),
          // GestureDetector(
          //   onTap: () {
          //     AppNavigator.currentState!.pop();
          //   },
          //   child: const Icon(Icons.close),
          // )
        ],
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: position,
      isDismissible: true,
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 4),
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      borderRadius: BorderRadius.circular(6),
    ).show(AppNavigator.currentContext!);
  }

  static void showError(
      {String? message,
      FlushbarPosition position = FlushbarPosition.TOP,
      EdgeInsets? margin}) {
    Flushbar(
      icon: const Icon(
        Icons.close,
        color: Colors.red,
      ),
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            message ?? 'Có lỗi xảy ra',
            style: AppTextStyle.black(14, weight: FontWeight.w600),
          ),
          // GestureDetector(
          //   onTap: () {
          //     AppNavigator.currentState!.pop();
          //   },
          //   child: const Icon(Icons.close),
          // )
        ],
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: position,
      isDismissible: true,
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 4),
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      borderRadius: BorderRadius.circular(6),
    ).show(AppNavigator.currentContext!);
  }
}
