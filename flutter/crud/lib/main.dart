import 'package:crud/estudante/mvvm/estudante_view_model.dart';
import 'package:crud/mainpage/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        
        create: (context) => EstudanteViewModel(),
        child: MaterialApp(
        title: 'AcadêmicoSys',
        theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        cardColor: Color(0x966d41),
        ),
        
      home: const MainPage(),
    ));
  }
}

