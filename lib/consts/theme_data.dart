import 'package:flutter/material.dart';

class Styles{
  static ThemeData themeData(bool isDark, context){
    return ThemeData(
      hintColor: Colors.green,
      scaffoldBackgroundColor: isDark ? const Color(0xff00001a) : const Color(0xffffffff),
      textTheme: TextTheme(bodyMedium: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 18)),
      dialogTheme: DialogTheme(backgroundColor: isDark ? const Color(0xff00001a) : const Color(0xffffffff)),
      appBarTheme: AppBarTheme(
          backgroundColor: isDark ? const Color(0xff00001a) : const Color(0xffffffff),
          iconTheme: IconThemeData(color: isDark ? const Color(0xffffffff) : const Color(0xff00001a),)),
      primaryColor:  Colors.green,
      colorScheme: ThemeData().colorScheme.copyWith(
        secondary:  isDark ? const Color(0xff1a1f3c) : const Color(0xffe8fdfd),
        brightness:  isDark ? Brightness.dark : Brightness.light,
      ),
      cardColor: isDark ? const Color(0xff0a02dc) : const Color(0xffe2fdfd),
      canvasColor: isDark ? Colors.black : Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
        colorScheme: isDark
            ? const ColorScheme.dark()
            : const ColorScheme.light()
      )
    );
  }
}