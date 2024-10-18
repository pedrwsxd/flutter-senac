class Contato {
  final int id;
  final String nome;
  final String email;
  final String telefone;


  Contato({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone

  });


  // Método para converter o JSON da API para um objeto Produto
  factory Contato.fromJson(Map<String, dynamic> json) {
    return Contato(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      telefone: json['telefone']
    );
  }
}
