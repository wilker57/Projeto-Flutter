import 'package:crud/core/tema_provider.dart';
import 'package:crud/estudante/mvvm/estudante_view_model.dart';
import 'package:crud/mainpage/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TemaProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final temaProvedor = Provider.of<TemaProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => EstudanteViewModel(),
      child: MaterialApp(
        title: 'AcadêmicoSys ',
        theme: temaProvedor.currentTheme,
        home: const MainPage(),
      ),
    );
  }
}
