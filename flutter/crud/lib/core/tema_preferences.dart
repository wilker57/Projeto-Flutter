import 'package:shared_preferences/shared_preferences.dart';

class TemaPreferences {
  static const keyTheme = "tema";

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(keyTheme, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(keyTheme) ?? false;
  }
}
