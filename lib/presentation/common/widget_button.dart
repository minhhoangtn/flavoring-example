import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  final Color color;
  final String? title;
  final TextStyle? textStyle;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final Widget? child;
  final bool isLoading;
  final bool isEnabled;
  final double? radius;
  final Color? borderColor;
  final Color? loadingColor;

  const WidgetButton(
      {Key? key,
      this.title,
      required this.color,
      this.child,
      this.onPressed,
      this.textStyle,
      this.height,
      this.isLoading = false,
      this.isEnabled = true,
      this.width,
      this.radius,
      this.borderColor,
      this.loadingColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? (isLoading ? null : onPressed) : null,
      child: Container(
        height: height ?? 40,
        width: width ?? 100,
        decoration: BoxDecoration(
            color: isEnabled ? color : Colors.grey,
            borderRadius: BorderRadius.circular(radius ?? 15),
            border:
                borderColor == null ? null : Border.all(color: borderColor!)),
        alignment: Alignment.center,
        child: isLoading
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: FittedBox(
                    child: CircularProgressIndicator(
                  color: loadingColor ?? Colors.white,
                )),
              )
            : child ??
                Text(
                  title ?? "",
                  style: isEnabled
                      ? textStyle ??
                          AppTextStyle.white(14, weight: FontWeight.bold)
                      : const TextStyle(color: Colors.grey),
                ),
      ),
    );
  }
}
