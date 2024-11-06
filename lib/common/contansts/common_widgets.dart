import 'package:flutter/material.dart';

import 'common_color.dart';

class CommonWidgets {
  static Widget space({double? height = 0, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static circularProgressIndicator({EdgeInsets? padding, Color? color}) {
    return Center(
        child: Padding(
          padding: padding ?? const EdgeInsets.all(0),
          child: CircularProgressIndicator(
            color: color ?? AppColors.primaryColor,
          ),
        ));
  }

  static autoText(String text, Color color,
      {FontWeight? fontWeight, double? fontSize, TextAlign? textAlign}) {
    return FittedBox(
      child: Text(
        text,
        textAlign: textAlign ?? TextAlign.center,
        style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize ?? 12,
        ),
      ),
    );
  }


}
