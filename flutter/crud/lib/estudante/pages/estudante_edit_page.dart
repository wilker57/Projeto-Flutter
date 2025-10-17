import 'package:crud/core/custom_textformfield.dart';
import 'package:crud/estudante/models/estudante.dart';
import 'package:crud/estudante/mvvm/estudante_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EstudanteEditPage extends StatelessWidget {
  EstudanteEditPage(this.est, {super.key});
  Estudante est;

  @override
  Widget build(BuildContext context) {
    TextEditingController matricula = TextEditingController();
    TextEditingController nome = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController curso = TextEditingController();
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
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30.0,
                  horizontal: 15,
                ),
                child: Column(
                  children: [
                    CustomTextFormField(
                      label: Text('Matrícula'),
                      validacao: 'A matrícula é obrigatória!!!',
                      controller: matricula,
                    ),
                    SizedBox(height: 15),
                    CustomTextFormField(
                      label: Text('Nome'),
                      validacao: 'O nome não pode ficar vazio!!!',
                      controller: nome,
                    ),
                    SizedBox(height: 15),
                    CustomTextFormField(
                      label: Text('Email'),
                      validacao: 'O email não pode ficar vazio!!!',
                      controller: email,
                    ),
                    SizedBox(height: 15),
                    CustomTextFormField(
                      label: Text('Curso'),
                      validacao: 'O curso não pode ficar vazio!!!',
                      controller: curso,
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
                                bool ok = await viewModel.atualizarEstudante(
                                  est,
                                );
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
                                    backgroundColor: Colors.green,
                                    msg:
                                        'Dados do estudante foram gravados com sucesso',
                                  );
                                  Navigator.of(context).pop();
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
