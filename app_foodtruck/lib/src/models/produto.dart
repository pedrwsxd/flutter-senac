class Produto {
  final int id;
  final String nome;
  final String tipo;
  final String imagemUrl;
  final double preco;


  Produto({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.imagemUrl,
    required this.preco,
  });


  // Método para converter o JSON da API para um objeto Produto
  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'],
      nome: json['nome'],
      tipo: json['tipo'],
      imagemUrl: json['imagemUrl'],
      preco: json['preco'].toDouble(),
    );
  }
}