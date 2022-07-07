import 'package:flutter/material.dart';

class KeyboardUtils {
  static void dismiss() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
