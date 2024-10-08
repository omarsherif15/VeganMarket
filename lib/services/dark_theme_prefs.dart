import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePrefs{
  static const THEME_STATUS = 'THEME_STATUS';

  setDarkThemeMode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getThemeData () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
  }