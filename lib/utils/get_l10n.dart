import 'package:flutter/widgets.dart';

import 'package:mood_n_habits/l10n/app_localizations.dart';

extension GetL10n on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
