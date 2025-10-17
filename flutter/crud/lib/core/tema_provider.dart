import 'package:crud/core/tema_preferences.dart';
import 'package:flutter/material.dart';

class TemaProvider extends ChangeNotifier {
  ThemeData _currentTheme = lightTheme;

  late bool _isDark;
  late TemaPreferences _preferences;

  bool get isDark => _isDark;

  ThemeData get currentTheme => _currentTheme;

  TemaProvider() {
    _isDark = false;
    _preferences = TemaPreferences();
    getPreferences();
  }
  void trocarTema() {
    _currentTheme = _currentTheme == lightTheme ? darkTheme : lightTheme;
    _isDark = _currentTheme == lightTheme ? true : false;
    _preferences.setTheme(_isDark);
    // temaEscuro();
    notifyListeners();
  }

  // bool temaEscuro() {
  //   _isDark = _currentTheme == lightTheme ? true : false;
  //   return _currentTheme == ThemeData.dark() ? true : false;
  // }

  //Switching the themes
  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorSchemeSeed: const Color.fromARGB(255, 4, 81, 16),
  // appBarTheme: AppBarTheme(
  //   backgroundColor: Color.fromARGB(255, 217, 238, 211),
  //   // foregroundColor: Color.fromARGB(255, 100, 81, 177),
  // ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(primary: Colors.black, secondary: Colors.grey),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.grey,
  ),
);
