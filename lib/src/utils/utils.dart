part of tie_picker;

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
}

extension Context on BuildContext {
  TextTheme get text => Theme.of(this).textTheme;

  TextStyle? get h1 => text.headline1;
  TextStyle? get h2 => text.headline2;
  TextStyle? get h3 => text.headline3;
  TextStyle? get h4 => text.headline4;
  TextStyle? get h5 => text.headline5;
  TextStyle? get h6 => text.headline6;
  TextStyle? get h7 => text.headline6?.copyWith(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      );

  TextStyle? get s1 => text.subtitle1;
  TextStyle? get s2 => text.subtitle2;
  TextStyle? get s3 => text.subtitle1?.copyWith(
        fontWeight: FontWeight.w700,
        color: Palette.gray2,
      );

  TextStyle? get b => text.button;

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
