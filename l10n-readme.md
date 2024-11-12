[//]: # (dfs)
# A cheatsheet on adding i18n to a Flutter app

Add dependencies:

```bash
flutter pub add flutter_localizations --sdk flutter
flutter pub add intl:any
```

Add `generate` to Flutter config:

```yaml
flutter:
  # ...
  generate: true
```

Create `lib/l10n/app_en.arb`:

```json
{
  "appTitle": "My fancy app",
  "@appTitle": {
    "description": "Localisation key description"
  }
}

```

Create `l10n.yaml`:

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localization.dart
```

Run the application to generate the code:

```bash
flutter run -d windows
```

**Note**: now it's a good time to restart IDEA, as it has terrible caching issues. Shame.

Import generated package, probably you'd need to do it manually:

```dart
import 'package:flutter_gen/gen_l10n/app_localization.dart';
```

Setup localization in `MaterialApp`:

```dart
    return MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
```

Use AppLocalizations for the simple messages as follows:

```dart
    AppBar(title: Text(AppLocalizations.of(context)!.appTitle))
```

Alternatively, create a shortcut utility class:

```dart
class L10n {
  static AppLocalizations of(BuildContext context) =>
      AppLocalizations.of(context)!;
}
```

Usage:

```dart
AppBar(title: Text(L10n.of(context).appTitle))
```

When using plurals, placeholder definition have 2 more arguments: static `plural` and space-separated cases.
If no numbered case (`=0{}`, `=42{}`, ...) found, default selection is used. 
Default selection is `other{...}`, where the body may use the placeholder:

```json
{
  "unread": "You have {amount, plural, =1{one unread message} other{{amount} unread messages}}",
  "@unread": {
    "placeholders": {
      "amount": {
        "type": "num"
      }
    }
  }
}
```