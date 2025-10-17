import 'package:crud/estudante/models/estudante.dart';
import 'package:crud/estudante/services/estudante_service.dart';
import 'package:flutter/material.dart';

class EstudanteViewModel extends ChangeNotifier {
  //-- lista de estudantes para ser utilizada na apresentação de
  //-- todos os estudantes registrados
  List<Estudante> _estudantes = [];
  //-- obtenção da instância do serviço de estudantes
  final EstudanteService _estudanteService = EstudanteService();
  List<Estudante> get estudantes => _estudantes;
  //obtém dados de todos os estudantes
  Future<void> lerEstudantes() async {
    _estudantes = await _estudanteService.getEstudantes();
    //notifica todos os objetos que dependerem da lista "_estudantes"
    notifyListeners();
  }

  EstudanteViewModel() {
    lerEstudantes();
  }

  Future<bool> adicionarEstudante(Estudante est) async {
    try {
      await _estudanteService.inserirEstudante(est);
      await lerEstudantes();
      return Future.value(true);
    } catch (e) {
      debugPrint(e.toString());
      return Future.value(false);
    }
  }

  Future<bool> atualizarEstudante(Estudante est) async {
    try {
      await _estudanteService.atualizarEstudante(est);
      await lerEstudantes();
      return Future.value(true);
    } on Exception catch (e) {
      // TODO
      debugPrint(e.toString());
      return Future.value(false);
    }
  }

  deletarEstudante(int id) async {
    await _estudanteService.deletarEstudante(id);
    await lerEstudantes();
  }
}
