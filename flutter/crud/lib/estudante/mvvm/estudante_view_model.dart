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
    //notifica todos os objetos que dependeram da lista
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

    deletarEstudante(int id) async {
      await _estudanteService.deletarEstudante(id);
      await lerEstudantes();
      
    }
  }

  /*Future<bool> atualizarEstudante (Estudante est) async {
    try {
      await _estudanteService.atualizarEstudante(est);
      await lerEstudantes();
      return Future.value(true);
  }on Exception Catch(e) {
    debugPrint(e.toString());
    return Future.value(false);
  }
  }

  Future<bool>editarEstudante(Estudante est) async {
    try {
      await _estudanteService.atualizarEstudante(est);
      await lerEstudantes();
      return Future.value(true);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Future.value(false);
    }
  }
*/