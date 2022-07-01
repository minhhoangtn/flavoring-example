import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flutter/material.dart';

class WidgetTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final FormFieldSetter<String>? onSaved;

  final bool enable;

  final AutovalidateMode? autoValidateMode;
  final String? initialValue;
  final bool? obscureText;
  final Widget? suffixIcon;
  final bool? readOnly;
  final VoidCallback? onTap;

  final int? maxLine;

  const WidgetTextField(
      {Key? key,
      this.initialValue,
      this.hintText = '',
      this.controller,
      this.onChanged,
      this.keyboardType = TextInputType.text,
      this.autoValidateMode,
      this.validator,
      this.onSaved,
      this.enable = true,
      this.obscureText = false,
      this.suffixIcon,
      this.readOnly,
      this.onTap,
      this.maxLine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double borderRadius = 15;
    double borderSide = 1;
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly ?? false,
      obscureText: obscureText!,
      obscuringCharacter: "*",
      enabled: enable,
      controller: controller,
      maxLines: obscureText != null ? 1 : maxLine,
      decoration: InputDecoration(
        filled: enable ? null : true,
        fillColor: enable ? null : AppColor.whiteFD,
        contentPadding: const EdgeInsets.only(
          left: 13,
          right: 15,
          top: 13,
          bottom: 13,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColor.redError, width: borderSide),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColor.redError, width: borderSide),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColor.orangeFF, width: borderSide),
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.orangeFF, width: borderSide),
            borderRadius: BorderRadius.circular(borderRadius)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.orangeFF, width: borderSide),
            borderRadius: BorderRadius.circular(
              borderRadius,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.orangeFF, width: borderSide),
            borderRadius: BorderRadius.circular(borderRadius)),
        // focusedErrorBorder: OutlineInputBorder(
        //   // borderRadius: BorderRadius.circular(10),
        //   borderSide: BorderSide(color: AppColor.lineGray),
        // ),
        errorStyle: AppTextStyle.errorText(14),
        hintText: hintText,
        hintStyle: AppTextStyle.hintText(14, weight: FontWeight.normal),
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 10), child: suffixIcon)
            : null,
        suffixIconConstraints:
            const BoxConstraints(minWidth: 15, minHeight: 15),
        isDense: true,
      ),
      initialValue: initialValue,
      autovalidateMode: autoValidateMode,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: AppTextStyle.black(14, weight: FontWeight.normal),
      onSaved: onSaved,
    );
  }
}
