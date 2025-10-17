import 'dart:io';

import 'package:crud/estudante/models/estudante.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class EstudanteService {
  //-- ADICIONAR O PACOTE DO SQLITE
  static Database? _database;

  static final EstudanteService _instancia = EstudanteService._internal();

  //-- cria um método construtor para ser utilizado somente
  //-- dentro desta classe
  EstudanteService._internal();

  //-- fabricando o padrão singleton
  factory EstudanteService() => _instancia;

  //ADICIONAR UM PACOTE PARA GERENCIAR A PASTA DE ARMAZENAMENTO

  Future<Database> _iniciarBancoDeDados() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'estudantes_banco.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _criarDB,
      onUpgrade: (db, oldVersion, newVersion) => _updateDB(db, newVersion),
    );
  }

  Future<void> _criarDB(Database db, int version) async {
    await db.execute(''' 
    CREATE TABLE estudantes(
      id INTEGER PRIMARY KEY AUTOINCREMENT ,
      matricula INTEGER,
      nome TEXT,
      email TEXT,
      curso TEXT,
      imagem TEXT
    ) 
    ''');
  }

  Future<void> _updateDB(Database db, int version) async {
    await db.execute(''' 
    ALTER TABLE estudantes ADD imagem TEXT 
    ''');
  }

  // a palavra chave "async" me garante processo assíncrono
  Future<int> inserirEstudante(Estudante est) async {
    Database db = await abrirDB;
    return await db.insert('estudantes', est.toMap());
  }

  Future<Database> get abrirDB async {
    if (_database != null) return _database!;
    _database = await _iniciarBancoDeDados();
    return _database!;
  }

  Future<List<Estudante>> getEstudantes() async {
    Database db = await abrirDB;
    List<Map<String, dynamic>> lista = await db.query('estudantes');
    return List.generate(lista.length, (i) {
      return Estudante.fromMap(lista[i]);
    });
  }

  Future atualizarEstudante(Estudante est) async {
    Database db = await abrirDB;
    return await db.update(
      'estudantes',
      est.toMap(),
      where: 'id = ?',
      whereArgs: [est.id],
    );
  }

  Future<int> deletarEstudante(int id) async {
    Database db = await abrirDB;
    return await db.delete('estudantes', where: 'id = ?', whereArgs: [id]);
  }
}
