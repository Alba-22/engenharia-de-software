import 'package:flutter/material.dart';
import 'package:turistando/app/core/utils/constants.dart';
import 'package:turistando/app/core/utils/custom_colors.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final double fontSize;
  final double borderSize;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CommonButton({
    Key? key,
    required this.text,
    this.isLoading = false,
    this.onTap,
    this.width = 150,
    this.height = 48,
    this.fontSize = 16,
    this.borderSize = 8,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? textColor;
    Color? loadingColor;
    Color? backgroundColor;
    if (onTap != null) {
      textColor = CColors.white;
      loadingColor = CColors.white;
      backgroundColor = CColors.primary;
    } else {
      textColor = CColors.white;
      loadingColor = CColors.white;
      backgroundColor = CColors.primary.withOpacity(0.5);
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: CColors.primary.withOpacity(0.5),
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(borderSize),
        child: Ink(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderSize),
            color: backgroundColor,
          ),
          child: isLoading ? _buttonLoading(loadingColor) : _buttonContent(textColor),
        ),
      ),
    );
  }

  Widget _buttonLoading(Color loadingColor) {
    return Center(
      child: SizedBox(
        height: height / 2,
        width: height / 2,
        child: CircularProgressIndicator(
          color: loadingColor,
          strokeWidth: height / 15,
        ),
      ),
    );
  }

  Widget _buttonContent(Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        prefixIcon ?? const SizedBox(),
        if (prefixIcon != null) const SizedBox(width: 12),
        Center(
          child: Text(
            text.toUpperCase(),
            maxLines: maxLines,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FWeight.bold,
            ),
          ),
        ),
        if (suffixIcon != null) const SizedBox(width: 12),
        suffixIcon ?? const SizedBox(),
      ],
    );
  }
}
