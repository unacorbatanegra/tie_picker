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

![Calendar](https://github.com/unacorbatanegra/tie_picker/assets/44511181/dc57aa0a-303a-4f1f-b600-f812d9bde7d1)

### ModalPicker

The modal picker accepts any `List<T>` argument with any `T` argument using the equality of the hashes for comparing the data.

Example:

```dart
class MyClass {
  final int id;
  final String value;

  MyClass({
    required this.id,
    required this.value,
  });

  @override
  bool operator ==(covariant MyClass other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode;
}

```

The `toText()` function allows parsing correctly any label from any `T` value. To perform a search, `TextField` uses the labeled result of the `toText()` function to lookup through the items.

Usage:

```dart
int? item = 0;

void openModalPicker() async {
    final result = await ModalPicker.modalPick<int>(
        context: context,
        label: 'Modal pick',
        list: List.generate(50, (index) => index),
        item: item,
        toText: (value) => 'Option $value',
    );
    if (result == null) return;
    item = result;
}
```

### MiniPicker

The MiniPicker is as the name said, a tiny version of the picker to choose between a tiny number of items. It behaves the same way as the [ModalPicker](#modalpicker).

Usage:

```dart
MyClass? data;

void openMiniPicker() async {
    final result = await ModalPicker.miniPick<MyClass>(
        context: context,
        label: 'Mini pick',
        list: List.generate(
        50,
        (index) => MyClass(id: index, value: "Option $index"),
        ),
        item: data,
        toText: (value) => 'Option $value',
    );
    if (result == null) return;
    data = result;
}
```
