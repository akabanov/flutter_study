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
