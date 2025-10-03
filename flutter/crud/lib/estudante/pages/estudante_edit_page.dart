import 'package:crud/estudante/models/estudante.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart' show Consumer;

import '../mvvm/estudante_view_model.dart';


class EstudanteEditPage extends StatelessWidget {
  EstudanteEditPage(this.est, {super.key});
  Estudante est;

  @override
  Widget build(BuildContext context) {
    
  Estudante est = Estudante();

    TextEditingController matricula = TextEditingController();
    TextEditingController nome = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController curso = TextEditingController();
    //preenchendo os campos textos com os dados do estudante
    //a ser editado
    matricula.text = est.matricula.toString();
    nome.text = est.nome!;
    email.text = est.email!;
    curso.text = est.curso!;

    //variável "formKey" é auxiliar de controle de conteúdo do
    //formulário onde se encontram os campos textos a serem validados
    var formKey = GlobalKey<FormState>();

    return Consumer<EstudanteViewModel>(
      builder: (context, viewModel, child) {
        return SafeArea(
          child: Scaffold(
            body: Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 6, 22, 6),
                    offset: Offset(0.5, 0.5),
                    spreadRadius: 1.5,
                  ),
                ],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) => value!.isEmpty
                          ? 'Campo matrícula é obrigatório!!!!'
                          : null,
                      controller: matricula,
                      decoration: InputDecoration(
                        label: Text('Matrícula'),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Nome não pode ficar vazio' : null,
                      controller: nome,
                      decoration: InputDecoration(
                        label: Text('Nome'),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Email não pode ficar vazio' : null,
            
                      controller: email,
                      decoration: InputDecoration(
                        label: Text('Email'),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Curso não pode ficar vazio' : null,
            
                      controller: curso,
                      decoration: InputDecoration(
                        label: Text('Curso'),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancelar"),
                          ),
                        ),
                        SizedBox(
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                est.nome = nome.text;
                                est.matricula = int.parse(matricula.text);
                                est.email = email.text;
                                est.curso = curso.text;
                                bool ok = await viewModel.adicionarEstudante(est);
                                if (ok) {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //     content: Text(
                                  //       'Dados do estudante foram gravados com sucesso',
                                  //     ),
                                  //     backgroundColor: Colors.amberAccent[400],
                                  //     duration: Duration(seconds: 5),
                                  //   ),
                                  // );
                                  myToastDialog(
                                    msg:
                                        'Dados do estudante foram gravados com sucesso',
                                  );
                                } else {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //     content: Text(
                                  //       'Problemas ao gravar dados da cotação',
                                  //     ),
                                  //     backgroundColor: Colors.amberAccent[400],
                                  //     duration: Duration(seconds: 5),
                                  //   ),
                                  // );
                                  myToastDialog(
                                    msg:
                                        'Ocorreu problemas na gravação de dados ',
                                  );
                                }
                              }
                            },
                            child: Text("Salvar"),
                            
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Future<bool?> myToastDialog({
  required String msg,
  Color backgroundColor = Colors.black,
  Color textColor = Colors.white,
}) {
  return Fluttertoast.showToast(
    msg: msg,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 14,
  );
}
