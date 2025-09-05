import 'package:crud/estudante/models/estudante.dart';
import 'package:crud/estudante/services/estudante_service.dart';
//Lista de estudantes para ser utilizada na apresentação de
//todos os estudantes registrados
class EstudanteViewModel {
  List<Estudante> _estudantes = [];

  //obtenção da instância
  EstudanteService _estudanteService = EstudanteService();

  Future<void> lerEstudantes() async {
    _estudantes = await _estudanteService.getEstudantes();
  }

  Future<void> adicionarEstudante(Estudante est) async {
    await _estudanteService.inserirEstudante(est);
    await lerEstudantes();
  }
}