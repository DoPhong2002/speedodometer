part of '../light_theme.dart';

class MyFilledButtonTheme extends FilledButtonThemeData {
  @override
  ButtonStyle? get style => FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      );
}
