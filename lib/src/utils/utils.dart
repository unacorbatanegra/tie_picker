import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension WidgetPaddingX on Widget {
  Widget paddingSymmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
        ),
        child: this,
      );
}

const radius8 = Radius.circular(8);

extension Context on BuildContext {
  TextTheme get text => theme.textTheme;

  ThemeData get theme => Theme.of(this);

  TextStyle? get h1 => text.displayLarge;
  TextStyle? get h2 => text.displayMedium;
  TextStyle? get h3 => text.displaySmall;
  TextStyle? get h4 => text.headlineMedium;
  TextStyle? get h5 => text.headlineSmall;
  TextStyle? get h6 => text.titleLarge;
  TextStyle? get h7 => text.titleLarge?.copyWith(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      );

  TextStyle? get s1 => text.titleMedium;
  TextStyle? get s2 => text.titleSmall;
  TextStyle? get s3 => text.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: Palette.gray2,
      );

  TextStyle? get b => text.labelLarge;

  Size get size => MediaQuery.of(this).size;

  double get w => size.width;
  double get h => size.height;
}

const emptyWidget = SizedBox.shrink();
const zero = EdgeInsets.zero;
const always = AlwaysScrollableScrollPhysics();

abstract class Palette {
  static const gray1 = Color(0xFF333333);
  static const gray2 = Color(0xFF4F4F4F);
  static const gray3 = Color(0xFF828282);
  static const gray4 = Color(0xFFBDBDBD);
  static const gray5 = Color(0xFFE0E0E0);
  static const gray6 = Color(0xFFF2F2F2);

  static const culture = Color(0xFFEFF1F3);
}

extension HelpS on String {
  String get capitalize {
    if (isEmpty) return '';
    return this[0].toUpperCase() + substring(1);
  }
}

extension DateCopyWith on DateTime {
  // ignore: unused_element

  String weekdayFormat(BuildContext context) {
    final _weekDayformat = DateFormat(
      'E',
      Localizations.localeOf(context).languageCode,
    );
    return _weekDayformat.format(this).capitalize.replaceAll('.', '');
  }

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) =>
      DateTime(
        year ?? this.year,
        month ?? this.month,
        day ?? this.day,
        hour ?? this.hour,
        minute ?? this.minute,
        second ?? this.second,
        millisecond ?? this.millisecond,
        microsecond ?? this.microsecond,
      );
}
