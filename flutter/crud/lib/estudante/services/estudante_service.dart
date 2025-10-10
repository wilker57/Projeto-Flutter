import 'dart:io';

import 'package:crud/estudante/models/estudante.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class EstudanteService {
  //ADICIONAR O PACOTE DO SQLITE
  static Database? _database;

  static final EstudanteService _instance = EstudanteService._internal();

  // -- Cria um método construtor para ser utilizado somente
  //-- dentro desta classe

  EstudanteService._internal();

  //-- fabricando o padrão singleton

  factory EstudanteService() => _instance;

  //ADICIONAR UM PACOTE PARA GERENCIAR A PASTA DE ARMAZENAMENTO

  Future<Database> _iniciarBancoDeDados() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'estudantes_banco.db');
    return await openDatabase(path, version: 1, onCreate: _criarDB);
  }

  Future<void> _criarDB(Database db, int version) async {
    await db.execute(''' 
    CREATE TABLE estudantes(
      id INTEGER PRIMARY KEY AUTOINCREMENT ,
      matricula INTEGER,
      nome TEXT,
      email TEXT,
      curso TEXT
    ) 
    ''');
  }
   // a palavra chave "async" me garante processo assíncrono
  Future<int> inserirEstudante(Estudante est) async {
    Database db = await obterDados;
    return await db.insert('estudantes', est.toMap());
  }

  Future<Database> get obterDados async {
    if (_database != null) return _database!;
    _database = await _iniciarBancoDeDados();
    return _database!;
  }

  Future<List<Estudante>> getEstudantes() async {
    Database db = await obterDados;
    List<Map<String, dynamic>> lista = await db.query('estudantes');
    return List.generate(lista.length, (i) {
      return Estudante.fromMap(lista[i]);
    });
  }
  
  Future<int>deletarEstudante(int id)async{
    Database db = await obterDados;
    return await db.delete('estudantes', where: 'id = ?', whereArgs: [id]);
  }
}

 Future atualizarEstudante (Estudante est) async {
    Database db = await EstudanteService().obterDados;
    return await db.update('estudantes', est.toMap(), where: 'id = ?', whereArgs: [est.id]);
 }

 