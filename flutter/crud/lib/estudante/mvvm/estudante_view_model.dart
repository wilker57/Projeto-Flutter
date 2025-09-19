import 'package:crud/estudante/models/estudante.dart';
import 'package:crud/estudante/services/estudante_service.dart';
import 'package:flutter/material.dart';

class EstudanteViewModel extends ChangeNotifier{
//Lista de estudantes para ser utilizada na apresentação de
//todos os estudantes registrados
  List<Estudante> _estudantes = [];

  //obtenção da instância
  final EstudanteService _estudanteService = EstudanteService();
  List<Estudante> get estudantes => _estudantes;

  Future<void> lerEstudantes() async {
    _estudantes = await _estudanteService.getEstudantes();
    notifyListeners();
  }
  
  EstudanteViewModel(){
    lerEstudantes();
  }
   // obtém dados de todoso os estudantes
  Future<bool> adicionarEstudante(Estudante est) async {
    try{
      await _estudanteService.inserirEstudante(est);
      await lerEstudantes();
      return Future.value(true);
    } catch (e){
      debugPrint(e.toString());
      return Future.value(false);
    }

  }
}