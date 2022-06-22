import 'package:flutter/material.dart';
import '../../resources/app_palette.dart';

import 'index.dart';

class AppPasswordInputField extends StatefulWidget {
  const AppPasswordInputField({
    this.controller,
    this.focusNode,
    this.hintText,
    this.validator,
    this.autofocus = false,
  });
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final bool autofocus;
  final FormFieldValidator<String>? validator;

  @override
  _AppPasswordInputFieldState createState() => _AppPasswordInputFieldState();
}

class _AppPasswordInputFieldState extends State<AppPasswordInputField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return AppTextInputField(
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      maxLines: 1,
      hintText: widget.hintText,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: obscureText,
      suffixIcon: InkWell(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Icon(
            Icons.visibility,
            color: obscureText
                ? AppPalette.textDisabledColor
                : AppPalette.textDarkColor,
          )),
    );
  }
}
