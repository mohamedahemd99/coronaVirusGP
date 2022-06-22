import 'package:flutter/material.dart';

enum PaletteType { light, dark }

class PaletteModel {
  const PaletteModel({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.text,
    required this.textDark,
    required this.textMedium,
    required this.textLight,
    required this.textWhite,
    required this.textDisabled,
    required this.surface,
    required this.background,
    required this.border,
    required this.borderLight,
    required this.borderLighter,
    required this.notificationUnread,
    required this.error,
    required this.skeleton,
    required this.success,
    required this.finalSaleTextColor,
  });
  final Color? primary;
  final Color? secondary;
  final Color? surface;
  final Color? background;
  final Color? accent;
  final Color? text;
  final Color? textDark;
  final Color? textMedium;
  final Color? textLight;
  final Color? textWhite;
  final Color? textDisabled;
  final Color? border;
  final Color? borderLight;
  final Color? borderLighter;
  final Color? notificationUnread;
  final Color? error;
  final Color? skeleton;
  final Color? success;
  final Color? finalSaleTextColor;
}

class AppPalette {
  static const MaterialColor kUnfoundedColor = Colors.red;
  static PaletteType paletteType = PaletteType.light;

  static const PaletteModel _lightPalette = PaletteModel(
    primary: Colors.red,
    secondary: Color(0xFF1C1D6B),
    accent: Color(0xFF172B4D),
    text: Color(0xFF92929D),
    textDark: Color(0xFF000000),
    textMedium: Color(0xFF444444),
    textLight: Color(0xFF6b7893),
    textWhite: Color(0xFFFFFFFF),
    textDisabled: Color(0xFFe1e4e9),
    border: Color(0xffDDDDDD),
    borderLight: Color(0xFFFAFAFB),
    borderLighter: Color(0xFF707070),
    surface: Color(0xFFF2AE2),
    background: Color(0xFFeff3fb),
    notificationUnread: Color(0x11EE4340),
    error: Color(0xFFFF1717),
    skeleton: Color(0xFFF2AE2E),
    success: Color(0xFF16CA05),
    finalSaleTextColor: Color(0xFFFFC4C9),
  );

  static Map<PaletteType, PaletteModel> _palette = {
    PaletteType.light: _lightPalette,
  };

  static Color get primaryColor {
    return _palette[AppPalette.paletteType]?.primary ?? kUnfoundedColor;
  }

  static Color get secondaryColor {
    return _palette[AppPalette.paletteType]?.secondary ?? kUnfoundedColor;
  }

  static Color get accentColor {
    return _palette[AppPalette.paletteType]?.accent ?? kUnfoundedColor;
  }

  static Color get textColor {
    return _palette[AppPalette.paletteType]?.text ?? kUnfoundedColor;
  }

  static Color get textDarkColor {
    return _palette[AppPalette.paletteType]?.textDark ?? kUnfoundedColor;
  }

  static Color get textMediumColor {
    return _palette[AppPalette.paletteType]?.textMedium ?? kUnfoundedColor;
  }

  static Color get textLightColor {
    return _palette[AppPalette.paletteType]?.textLight ?? kUnfoundedColor;
  }

  static Color get textWhiteColor {
    return _palette[AppPalette.paletteType]?.textWhite ?? kUnfoundedColor;
  }

  static Color get textDisabledColor {
    return _palette[AppPalette.paletteType]?.textDisabled ?? kUnfoundedColor;
  }

  static Color get borderColor {
    return _palette[AppPalette.paletteType]?.border ?? kUnfoundedColor;
  }

  static Color get borderLightColor {
    return _palette[AppPalette.paletteType]?.borderLight ?? kUnfoundedColor;
  }

  static Color get borderLighterColor {
    return _palette[AppPalette.paletteType]?.borderLighter ?? kUnfoundedColor;
  }

  static Color get surfaceColor {
    return _palette[AppPalette.paletteType]?.surface ?? kUnfoundedColor;
  }

  static Color get backgroundColor {
    return _palette[AppPalette.paletteType]?.background ?? kUnfoundedColor;
  }

  static Color get notificationUnreadColor {
    return _palette[AppPalette.paletteType]?.notificationUnread ??
        kUnfoundedColor;
  }

  static Color get errorColor {
    return _palette[AppPalette.paletteType]?.error ?? kUnfoundedColor;
  }

  static Color get skeletonColor {
    return _palette[AppPalette.paletteType]?.skeleton ?? kUnfoundedColor;
  }

  static Color get successColor {
    return _palette[AppPalette.paletteType]?.success ?? kUnfoundedColor;
  }

  static Color get finalSaleTextcolor {
    return _palette[AppPalette.paletteType]?.finalSaleTextColor ??
        kUnfoundedColor;
  }
}
