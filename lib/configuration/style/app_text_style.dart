import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle black(double size, {FontWeight weight = FontWeight.normal}) {
    return TextStyle(fontSize: size, fontWeight: weight, color: Colors.black);
  }

  static TextStyle white(double size, {FontWeight weight = FontWeight.normal}) {
    return TextStyle(
        fontSize: size, fontWeight: weight, color: AppColor.whiteFD);
  }

  static TextStyle hintText(double size, {FontWeight weight = FontWeight.normal}) {
    return TextStyle(
        fontSize: size, fontWeight: weight, color: AppColor.greyHint);
  }

  static TextStyle errorText(double size, {FontWeight weight = FontWeight.normal}) {
    return TextStyle(
        fontSize: size, fontWeight: weight, color: AppColor.redError);
  }
}
