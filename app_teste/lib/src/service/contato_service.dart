import 'dart:convert';
import 'package:app_teste/src/models/contato.dart';
import 'package:http/http.dart' as http;


class ContatoService {
  final String apiUrl = 'http://localhost:8080/contatos';


  Future<List<Contato>> fetchContatos() async {
    final response = await http.get(Uri.parse(apiUrl));


    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Contato> contatos = body.map((dynamic item) => Contato.fromJson(item)).toList();
      return contatos;
    } else {
      throw Exception('Erro ao carregar contatos');
    }
  }
}
