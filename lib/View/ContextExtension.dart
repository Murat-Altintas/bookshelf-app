import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height / 100;
  double get width => mediaQuery.size.width / 100;

  double get lowText => height * 2;
  double get normalText => height * 2.5;
  double get highText => height * 3.5;

  double get lowValue => width * 3;
  double get mediumValue => width * 4;
  double get highValue => width * 6;


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
  EdgeInsets get paddingLow => EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get paddingMedium => EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingHeight => EdgeInsets.symmetric(horizontal: highValue);
}
