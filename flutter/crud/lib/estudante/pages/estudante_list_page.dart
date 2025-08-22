import 'package:crud/estudante/pages/estudante_add_page.dart';
import 'package:flutter/material.dart';

class EstudanteListPage extends StatelessWidget {
  const EstudanteListPage({super.key});

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      
      floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog(
          context: context,
          builder: (context) => EstudanteAddPage(),
        );
      },

       child: Icon(Icons.add, size:30),

      ),
    );
  }
}