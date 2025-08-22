//Classe de dados para ser utilizado como DTO
class Estudante{

  int? id;
  int? matricula;
  String? nome;
  String? curso;
  String? email;

  Estudante({this.id, this.matricula, this.curso, this.nome, this.email});

  //método para converter uma coleção do tipo MAPA
  //onde esla coleção é compatível como o formato JSON

  Map<String, dynamic> toMap(){

    return{
      'id': id,
      'matricula': matricula,
      'nome': nome,
      'curso': curso,
      'email': email,

    };
  }

  //método para receber dados de alguma entidade (banco de dados)
  //para ser utilizado dem alguma regra de negócio

  factory Estudante.fromMap(Map<String, dynamic> map){

    return Estudante(

      id: map['id'],
      curso: map['curso'],
      matricula: map['matricula'],
      email: map['email'],
      nome: map['nome'],
      
    );

  }

}