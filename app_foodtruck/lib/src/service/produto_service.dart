import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_foodtruck/src/models/produto.dart';

class ProdutoService {
  final String apiUrl = 'http://localhost:8080/produtos/listar';

  Future<List<Produto>> fetchProdutos() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Produto> produtos = body.map((dynamic item) => Produto.fromJson(item)).toList();
      return produtos;
    } else {
      throw Exception('Erro ao carregar produtos');
    }
  }
}
