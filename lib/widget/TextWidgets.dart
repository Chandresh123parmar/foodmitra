
import 'package:flutter/material.dart';

Widget text(
    String? text, {
      double fontSize = 18.0,
      Color? textColor,
      String? fontFamily,
      bool isCentered = false,
      int maxLine=1,
      double latterSpacing = 0.5,
      bool textAllCaps = false,
      bool isLongText = false,
      bool lineThrough = false,
      FontWeight fontWeight = FontWeight.normal,
      overflow,
      softWrap,
      maxLines, // Added fontWeight parameter
    }) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      color: textColor ?? Colors.black,
      height: 1.5,
      letterSpacing: latterSpacing,
      fontWeight: fontWeight, // Applied fontWeight
      decoration: lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}
