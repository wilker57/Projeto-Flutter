//classe de dados para ser utilizado como DTO
class Estudante {
  int? id;
  int? matricula;
  String? nome;
  String? curso;
  String? email;
  String? imagem;

  Estudante({
    this.id,
    this.matricula,
    this.curso,
    this.nome,
    this.email,
    this.imagem,
  });

  //método para converter para uma coleção do tipo MAPA
  //onde esta coleção é compátivel com o formato JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'matricula': matricula,
      'nome': nome,
      'curso': curso,
      "email": email,
      'imagem': imagem,
    };
  }

  //Método para receber dados de alguma entidade (banco de dados)
  //para ser utilizado em alguma regra de negócio

  //método para converte variáveis de instância em uma
  //coleção do tipo MAPA COMPÁTIVEL COM O JSON
  factory Estudante.fromMap(Map<String, dynamic> map) {
    return Estudante(
      id: map['id'],
      curso: map['curso'],
      email: map['email'],
      matricula: map['matricula'],
      nome: map['nome'],
      imagem: map['imagem'],
    );
  }
}
