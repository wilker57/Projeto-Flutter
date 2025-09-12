import 'package:crud/estudante/models/estudante.dart';
import 'package:crud/estudante/services/estudante_service.dart';
import 'package:flutter/material.dart';

class EstudanteViewModel extends ChangeNotifier{
//Lista de estudantes para ser utilizada na apresentação de
//todos os estudantes registrados
  List<Estudante> _estudantes = [];

  //obtenção da instância
  EstudanteService _estudanteService = EstudanteService();

  Future<void> lerEstudantes() async {
    _estudantes = await _estudanteService.getEstudantes();
    notifyListeners();
  }
  
   // obtém dados de todoso os estudantes
  Future<void> adicionarEstudante(Estudante est) async {
    await _estudanteService.inserirEstudante(est);
    await lerEstudantes();
  }
}