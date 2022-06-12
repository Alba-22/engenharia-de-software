import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:turistando/app/core/utils/constants.dart';
import 'package:turistando/app/core/utils/custom_colors.dart';

class CommonField extends StatelessWidget {
  final void Function(String)? onChange;
  final TextEditingController? controller;
  final String? label;
  final String placeholder;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final bool obscure;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final Widget? suffixIcon;
  final bool autoCorret;
  final TextInputAction? inputAction;
  final void Function(String)? onSubmit;
  final String? initialValue;
  final bool readOnly;
  final int minLines;
  final int maxLines;

  const CommonField({
    Key? key,
    this.onChange,
    this.controller,
    this.label,
    this.placeholder = "",
    this.inputFormatters = const [],
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.suffixIcon,
    this.autoCorret = false,
    this.inputAction,
    this.onSubmit,
    this.initialValue,
    this.readOnly = false,
    this.minLines = 1,
    this.maxLines = 1,
  })  : assert(
          initialValue == null || controller == null,
          "You cannot pass initialValue AND controller at the same time",
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Container(
            margin: const EdgeInsets.only(bottom: 6),
            child: Text(
              "${label!.toUpperCase()}:",
              style: const TextStyle(
                color: CColors.title,
                fontSize: 16,
                fontWeight: FWeight.bold,
              ),
            ),
          ),
        Stack(
          children: [
            TextFormField(
              cursorHeight: 20,
              onFieldSubmitted: onSubmit,
              textInputAction: inputAction,
              controller: controller,
              onChanged: onChange,
              initialValue: initialValue,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              obscureText: obscure,
              cursorColor: Colors.black,
              validator: validator,
              autovalidateMode: autovalidateMode,
              autocorrect: autoCorret,
              readOnly: readOnly,
              maxLines: maxLines,
              minLines: minLines,
              style: const TextStyle(
                color: CColors.title,
                fontSize: 16,
                fontWeight: FWeight.bold,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  left: 10,
                  top: 8,
                  right: suffixIcon != null ? 44 : 8,
                  bottom: 8,
                ),
                errorStyle: const TextStyle(
                  color: CColors.red,
                  fontSize: 12,
                  fontWeight: FWeight.semiBold,
                ),
                hintText: placeholder,
                hintStyle: const TextStyle(
                  color: CColors.gray,
                  fontSize: 16,
                  fontWeight: FWeight.bold,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    color: CColors.primary,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    color: CColors.primary,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    color: CColors.red,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    color: CColors.red,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              height: 50,
              child: suffixIcon ?? Container(),
            ),
          ],
        ),
      ],
    );
  }
}
