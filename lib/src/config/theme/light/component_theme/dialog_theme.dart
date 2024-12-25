part of '../light_theme.dart';

class MyDialogTheme extends DialogTheme {
  const MyDialogTheme({super.key});

  @override
  Color? get surfaceTintColor => Colors.white;

  @override
  ShapeBorder? get shape => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      );
}
