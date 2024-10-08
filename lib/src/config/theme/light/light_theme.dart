import 'package:flutter/material.dart';

import '../../../gen/colors.gen.dart';

part 'component_theme/dialog_theme.dart';
part 'component_theme/filled_button_theme.dart';
part 'component_theme/icon_button_theme.dart';
part 'component_theme/outlined_button_theme.dart';
part 'component_theme/text_button_theme.dart';
part 'component_theme/text_theme.dart';
 
ThemeData lightThemeData = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: MyColors.primary,
  ),
  useMaterial3: true,
  textTheme: MyTextTheme(),
  dialogTheme: MyDialogTheme(),
  filledButtonTheme: MyFilledButtonTheme(),
  iconButtonTheme: MyIconButtonTheme(),
  outlinedButtonTheme: MyOutlinedButtonTheme(),
  textButtonTheme: MyTextButtonTheme(),
);