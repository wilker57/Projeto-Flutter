import 'dart:io';

import 'package:crud/core/tema_provider.dart';
import 'package:crud/estudante/mvvm/estudante_view_model.dart';
import 'package:crud/estudante/pages/estudante_add_page.dart';
import 'package:crud/estudante/pages/estudante_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EstudanteListPage extends StatelessWidget {
  const EstudanteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final temaProvider = Provider.of<TemaProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('CRUD'),
              Switch(
                value: temaProvider.isDark,
                onChanged: (value) {
                  if (value) {
                    temaProvider.trocarTema();
                  } else {
                    temaProvider.trocarTema();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: Consumer<EstudanteViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.estudantes.isEmpty) {
            return Center(child: Text("Banco de dados vazio!"));
          }
          return ListView.builder(
            itemCount: viewModel.estudantes.length,
            itemBuilder: (context, index) {
              final estudante = viewModel.estudantes[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipOval(
                      child: Image.file(
                        File(estudante.imagem!),
                        width: 70,
                        height: 70,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${estudante.nome}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Text('${estudante.matricula}'),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // viewModel.deletarEstudante(estudante.id!);
                        _showDialogConfirmacao(
                          context,
                          viewModel,
                          estudante.id!,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.green),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                EstudanteEditPage(viewModel.estudantes[index]),
                          ),
                        );
                      },
                    ),
                  ],
                ),
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
                await viewModel.deletarEstudante(id);

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
