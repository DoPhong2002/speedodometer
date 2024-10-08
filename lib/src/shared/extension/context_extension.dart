import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ContextExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  double get bottomBarHeight => MediaQuery.of(this).padding.bottom;

  double get statusBarHeight => MediaQuery.of(this).padding.top;
}