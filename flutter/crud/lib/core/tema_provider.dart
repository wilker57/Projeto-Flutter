import 'package:flutter/material.dart';

class TemaProvider extends ChangeNotifier {
  ThemeData _temaAtual = lightTheme;

  ThemeData get temaAtual => _temaAtual;

  void alternarTema() {
    _temaAtual = _temaAtual.brightness == Brightness.dark ? lightTheme : darkTheme;
    notifyListeners();
  }
}

final lightTheme = ThemeData(
  brightness: Brightness.light,
  colorSchemeSeed: const Color.fromARGB(255, 6, 123, 53),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorSchemeSeed: const Color.fromARGB(255, 12, 12, 12),
);