class Bebida {
  final int id;
  final String nome;
  final String categoria;
  final String imagemUrl;
  final double preco;


  Bebida({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.imagemUrl,
    required this.preco,
  });


  // Método para converter o JSON da API para um objeto Produto
  factory Bebida.fromJson(Map<String, dynamic> json) {
    return Bebida(
      id: json['id'],
      nome: json['nome'],
      categoria: json['categoria'],
      imagemUrl: json['imagemUrl'],
      preco: json['preco'].toDouble(),
    );
  }
}
