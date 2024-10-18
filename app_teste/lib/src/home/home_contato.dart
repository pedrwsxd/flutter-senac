import 'package:app_teste/src/models/contato.dart';
import 'package:app_teste/src/service/contato_service.dart';
import 'package:flutter/material.dart';

class HomeContato extends StatefulWidget {
  const HomeContato({super.key});
 
  @override
  State<HomeContato> createState() => _HomeContatoState();
}

class _HomeContatoState extends State<HomeContato> {
  late Future<List<Contato>> futureContatos;

  @override
  void initState() {
    super.initState();
    futureContatos = ContatoService().fetchContatos();
  }

  // Função para separar os contatos por id
  Map<int, List<Contato>> agruparContatosPorId(List<Contato> contatos) {
    Map<int, List<Contato>> contatosPorId = {};
    for (var contato in contatos) {
      if (!contatosPorId.containsKey(contato.id)) {
        contatosPorId[contato.id] = [];
      }
      contatosPorId[contato.id]!.add(contato);
    }
    return contatosPorId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos do teste'),
      ),
      body: FutureBuilder<List<Contato>>(
        future: futureContatos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os contatos'));
          } else if (snapshot.hasData) {
            Map<int, List<Contato>> contatosPorId =
                agruparContatosPorId(snapshot.data!);
            return ListView(
              children: contatosPorId.keys.map((int id) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        id.toString(), // Convertendo o ID para string
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      children: contatosPorId[id]!.map((Contato contato) {
                        return Card(
                          child: ListTile(
                            title: Text(contato.nome),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(contato.email),
                                Text(contato.telefone)
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              }).toList(),
            );
          } else {
            return Center(child: Text('Nenhum contato encontrado'));
          }
        },
      ),
    );
  }
}
