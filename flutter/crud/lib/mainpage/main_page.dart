import 'package:crud/estudante/pages/estudante_list_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crud de Estudantes')),
          body: [
            Container(color: Colors.blue),
            Container(color: Colors.yellow),
            EstudanteListPage(),
          ][_index],
      backgroundColor: Color.fromARGB(255, 228, 225, 238),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) {
          setState(() {
            _index = value;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home_filled), label: 'Início'),
          NavigationDestination(icon: Icon(Icons.list), label: 'Boletins'),
          NavigationDestination(icon: Icon(Icons.person_2), label: 'Perfil'),
        ],
      ),
    );
  }
}
