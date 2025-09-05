import 'package:flutter/material.dart';

class EstudanteAddPage extends StatelessWidget {
  const EstudanteAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controladores para os campos do formulário
    final TextEditingController matriculaController = TextEditingController();
    final TextEditingController nomeController = TextEditingController();
    final TextEditingController cursoController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

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
              controller: matriculaController,
              decoration: InputDecoration(
                labelText: 'Matrícula',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: cursoController,
              decoration: InputDecoration(
                labelText: 'Curso',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: emailController,
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
                    // Aqui você pode acessar os valores:
                    // matriculaController.text, nomeController.text, cursoController.text, emailController.text
                  }, 
                  child: Text("Salvar")
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}