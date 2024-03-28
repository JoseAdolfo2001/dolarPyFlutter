import 'package:flutter/material.dart';

const colorList = <Color>[
  Color(0xFF99BC85)
];

class AppTheme{

  final int selectedColor;

  AppTheme([
    this.selectedColor = 0
  ]);


  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: colorList[selectedColor],
    appBarTheme:  AppBarTheme(
      backgroundColor: colorList[selectedColor]
    )
  );

}