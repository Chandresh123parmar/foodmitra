
import 'dart:ui';

int customColor(String colorCode) {
  String colors = "0xFF${colorCode.replaceAll("#", "")}";
  return int.parse(colors);
}


class AppColor {

  static const Color black= Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF898989);

  static const Color main_primary = Color(0xFF9747FF);
  static const Color main_secondry = Color(0xFFEFC2FF);
  static const Color main_secondry2 = Color(0xFFC3EFFF);
}