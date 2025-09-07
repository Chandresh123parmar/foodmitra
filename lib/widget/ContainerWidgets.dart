import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customContainer({
  required Widget child,
  Color? color,
  double? width,
  double? height,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  BoxDecoration? decoration,
  AlignmentGeometry alignment = Alignment.center,
}) {
  return Container(
    width: width,
    height: height,
    padding: padding,
    margin: margin,
    alignment: alignment,
    decoration: decoration ?? BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      // You can add more decoration properties here if needed.
    ),
    child: child,
  );
}
