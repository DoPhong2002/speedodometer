import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../config/di/di.dart';
import '../config/navigation/app_router.dart';

/// Localization
mixin L10n {
  static AppLocalizations get tr {
    final context = getIt<AppRouter>().navigatorKey.currentContext!;
    return AppLocalizations.of(context);
  }
}
