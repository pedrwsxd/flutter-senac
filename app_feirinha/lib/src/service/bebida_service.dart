import 'dart:convert';
import 'package:app_feirinha/src/models/bebida.dart';
import 'package:http/http.dart' as http;


class BebidaService {
  final String apiUrl = 'http://localhost:8080/bebidas';


  Future<List<Bebida>> fetchBebidas() async {
    final response = await http.get(Uri.parse(apiUrl));


    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);

      List<dynamic> body = json.decode(decodedResponse);
      List<Bebida> Bebidas = body.map((dynamic item) => Bebida.fromJson(item)).toList();
      return Bebidas;
    } else {
      throw Exception('Erro ao carregar Bebidas');
    }
  }
}
