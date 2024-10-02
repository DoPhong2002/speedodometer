part of '../light_theme.dart';

class MyTextButtonTheme extends TextButtonThemeData {
  @override
  ButtonStyle? get style => TextButton.styleFrom(
          textStyle: const TextStyle(
        fontSize: 14,
      ));
}
