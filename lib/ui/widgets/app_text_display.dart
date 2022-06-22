import 'package:flutter/material.dart';

import '../resources/app_palette.dart';


class AppText extends StatelessWidget {
  const AppText({
    this.color,
    this.fontSize = 15.0,
    this.text,
    this.fontFamily,
    this.decoration,
    this.translation,
    this.overflow = TextOverflow.ellipsis,
    this.style,
    this.leading,
    this.softWrap = false,
    this.maxLines = 2,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.normal,
    this.isUpper = false,
  });
  final Color? color;
  final double? fontSize;
  final String? text;
  final String? translation;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign textAlign;
  final bool? isUpper;
  final bool? softWrap;
  final int maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final Widget? leading;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = style!;
    if (color != null) {
      textStyle = textStyle.copyWith(
          color: color ?? AppPalette.textColor,
          fontSize: fontSize,
          fontWeight: fontWeight);
    }
    if (leading != null) {
      return Row(
        children: <Widget>[
          leading!,
          const SizedBox(width: 2),
          buildText(context, textStyle)
        ],
      );
    }
    return buildText(context, textStyle);
  }

  Text buildText(BuildContext context, TextStyle textStyle) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: textStyle,
    );
  }
}
