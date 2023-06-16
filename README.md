[![Pub Package](https://img.shields.io/pub/v/tie_picker.svg)](https://pub.dev/packages/tie_picker)

# Tie Picker

Tie picker is a minimalist opinionated helper for custom selectors and DateTime that support Theme Colors (only light mode supported right now) and internationalization.

![demo2](https://github.com/unacorbatanegra/tie_picker/assets/44511181/95efe503-0f0e-48e8-befc-f3e1e793ec7c)

## Index

- [Calendar](#calendar)
- [ModalPicker](#modalpicker)
- [MiniPicker](#minipicker)

## Using TiePicker

1. [Install](https://pub.dev/packages/tie_picker/install)

2. To support internationalization add the following to your `MaterialApp`

```dart
    import 'package:tie_picker/tie_picker.dart';
```

```dart
    MaterialApp(
        locale: const Locale('en'),
        /// Add the supported locales
        supportedLocales: TiePickerLocalizations.supportedLocales,
        localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            /// Add the localizations delegate
            TiePickerLocalizations.delegate
        ],
    );
```

### Calendar

To use the calendar pass the actual Date on the Date argument. Localizations are used and required to have a proper format for the dates.

You can set the selector from one of the following modes:

``` dart
enum CalendarMode {
  day,
  month,
  year,
}
```

Usage:

```dart
date = await ModalPicker.datePicker(
    context: context,
    date: date,
    mode: CalendarMode.day,
);

```

### ModalPicker

### MiniPicker
