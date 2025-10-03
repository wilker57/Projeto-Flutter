import 'package:crud/estudante/mvvm/estudante_view_model.dart';
import 'package:crud/estudante/pages/estudante_add_page.dart';
import 'package:crud/estudante/pages/estudante_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EstudanteListPage extends StatelessWidget {
  const EstudanteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<EstudanteViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.estudantes.isEmpty) {
            return Center(child: Text("Banco de dados vazio!"));
          }
          return ListView.builder(
            itemCount: viewModel.estudantes.length,
            itemBuilder: (context, index) {
              final estudante = viewModel.estudantes[index];
              return ListTile(
                title: Text('${estudante.nome}'),
                subtitle: Text('${estudante.matricula}'),
                trailing: SizedBox(
                  width: 96,
                    child: Row( 
                      children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: const Color.fromARGB(255, 252, 19, 2)), 
                        onPressed: () {
                          // viewModel.deletarEstudante(estudante.id!);
                          _showDialogConfirmacao(context, viewModel, estudante.id!);
                        },
                      ),
                      IconButton(
                    icon: Icon(Icons.edit, color: Colors.black), 
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EstudanteEditPage(viewModel.estudantes[index]),
                        ),
                      );
                    },
                  ),
                  ],
                ),
                )
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => EstudanteAddPage(),
          );
        },
        child: Icon(Icons.add, size: 30),
      ),
    );
  }

  Future<void> _showDialogConfirmacao(
    BuildContext context,
    EstudanteViewModel viewModel,
    int id,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Deleção'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Você tem certeza disso, Você quer apagar mesmo este estudante?',
                ),
                Text('Esta ação não pode ser retroagida.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                Navigator.of(context).pop();
                await viewModel.deletarEstudante(id);
              },
            ),
          ],
        );
      },
    );
  }
}
