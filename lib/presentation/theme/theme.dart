import 'package:flutter/material.dart';

class AppTheme {
  static const double margin = 8;

  //colors
  static const Color secondaryColor = Color(0xffff944d);

 static const double borderRadius = 6;
    ///returns the standard box decoration
  static BoxDecoration getBoxDecoration(context,
          {final bool isError = false}) =>
      BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          border: isError
              ? Border.all(color: Theme.of(context).errorColor, width: 1.3)
              : Border.all(
                  color: Theme.of(context).unselectedWidgetColor, width: 1.3));
}
