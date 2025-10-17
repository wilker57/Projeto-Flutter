import 'dart:io';

import 'package:crud/estudante/models/estudante.dart';
import 'package:crud/estudante/mvvm/estudante_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as syspath;

class EstudanteAddPage extends StatefulWidget {
  const EstudanteAddPage({super.key});

  @override
  State<EstudanteAddPage> createState() => _EstudanteAddPageState();
}

class _EstudanteAddPageState extends State<EstudanteAddPage> {
  File? imagemLocal;
  File? _foto;
  @override
  Widget build(BuildContext context) {
    Estudante est = Estudante();
    TextEditingController matricula = TextEditingController();
    TextEditingController nome = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController curso = TextEditingController();
    //variável "formKey" é auxiliar de controle de conteúdo do
    //formulário onde se encontram os campos textos a serem validados
    var formKey = GlobalKey<FormState>();

    return Consumer<EstudanteViewModel>(
      builder: (context, viewModel, child) {
        return Dialog(
          child: Container(
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
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    InkWell(
                      onTap: _obterImage,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: _foto == null
                            ? Icon(Icons.photo_album)
                            : ClipOval(
                                child: Image.file(_foto!, fit: BoxFit.fill),
                              ),
                      ),
                    ),
                    SizedBox(height: 10),
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
                                est.imagem = imagemLocal!.path;
                                bool ok = await viewModel.adicionarEstudante(
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

  Future<void> _obterImage() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListTile(
          onTap: () {
            obterImagemGaleria();
          },
          title: Text('Galeria'),
          leading: Icon(Icons.photo_library_rounded),
        );
      },
    );
  }

  Future<void> obterImagemGaleria() async {
    final picker = ImagePicker();
    final XFile? imagemObtida = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 100,
      maxHeight: 100,
    );
    if (imagemObtida != null) {
      final Directory appDir = await syspath.getApplicationDocumentsDirectory();
      final String appPath = appDir.path;
      final String nomeArquivo = path.basename(imagemObtida.path);
      final String localPath = path.join(appPath, nomeArquivo);
      imagemLocal = await File(imagemObtida.path).copy(localPath);
      var imagemArquivo = File(imagemObtida.path);
      setState(() {
        _foto = imagemArquivo;
      });
    }
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
