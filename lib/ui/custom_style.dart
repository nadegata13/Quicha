import 'package:flutter/material.dart';

class CustomStyle{
  static ButtonStyle transparentBtnStyle = ElevatedButton.styleFrom(primary: Colors.transparent, elevation: 0, padding: EdgeInsets.zero, );
  static TextStyle listTextStyle({required fontSize}) => TextStyle(fontSize: fontSize);

}

class CustomColor{

  static Color thinBlue = Color(0xFFe1ecef);
  static Color backgroundYellow = Color(0xFFf1c621);
  static Color appBarTheme = Color(0xFFe78d08);
  static Color userIconFrame = Color(0xFFa4a0a0);
  static Color selectIconBackground = Color(0xFFaab9bc);
  static Color darkBlue = Color(0xFF667984);

}
