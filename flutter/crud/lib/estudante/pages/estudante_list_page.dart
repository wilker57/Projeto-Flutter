import 'package:crud/estudante/mvvm/estudante_view_model.dart';
import 'package:crud/estudante/pages/estudante_add_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EstudanteListPage extends StatelessWidget {
  const EstudanteListPage({super.key});

  @override
  Widget build(BuildContext context) {

    return  Scaffold(

      body: Consumer<EstudanteViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.estudantes.isEmpty) {
            return Center(
              child: Text('Banco de dados vazio'),
            );
          } 
            return ListView.builder(

            
              itemCount: viewModel.estudantes.length,
              itemBuilder: (context, index){

                final estudante = viewModel.estudantes[index];

                return ListTile(

                  title: Text('${estudante.nome}'),
                  subtitle: Text('Matrícula: ${estudante.matricula}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Implementar a funcionalidade de exclusão se necessário
                    },
                  ),
                );
              },
                );
              },
            ),
          

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