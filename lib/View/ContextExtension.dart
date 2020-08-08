import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height / 100;

  double get width => mediaQuery.size.width / 100;

  double get lowestText => height * 1.7;

  double get lowText => height * 2;

  double get normalText => height * 2.5;

  double get paddingLowValue => width * 1;

  double get paddingMediumValue => width * 5;

  double get iconSize => height * 5;

  double get lowestContainer => height * 3;

  double get lowContainer => height * 5;

  double get mediumContainer => height * 7;

  double get highContainer => height * 9;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colors => theme.colorScheme;
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingMedium => EdgeInsets.symmetric(horizontal: paddingMediumValue);

  EdgeInsets get paddingLow => EdgeInsets.symmetric(horizontal: paddingLowValue);
}
