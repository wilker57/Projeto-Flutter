import 'package:crud/estudante/models/estudante.dart';
import 'package:crud/estudante/mvvm/estudante_view_model.dart' show EstudanteViewModel;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EstudanteAddPage extends StatelessWidget {
  const EstudanteAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    Estudante est = Estudante();

    // Controladores para os campos do formulário
    TextEditingController matricula = TextEditingController();
    TextEditingController nome = TextEditingController();
    TextEditingController curso = TextEditingController();
    TextEditingController email = TextEditingController();

    return Consumer<EstudanteViewModel>(
      builder: (context, viewModel, child) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(10),
            height: 400,
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 6, 22, 6),
                offset: Offset(0.5, 0.5),
                spreadRadius: 1.5,
              ),
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: matricula,
                decoration: InputDecoration(
                  labelText: 'Matrícula',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: nome,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: curso,
                decoration: InputDecoration(
                  labelText: 'Curso',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    }, 
                    child: Text("Cancelar")
                  ),
                  ElevatedButton(
                    onPressed: () {
                      est.nome = nome.text;
                      est.matricula = int.tryParse(matricula.text);
                      est.curso = curso.text;
                      est.email = email.text;
                      
                      viewModel.adicionarEstudante(est);
                      
                    }, 
                    child: Text("Salvar")
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  
    });
  }
}