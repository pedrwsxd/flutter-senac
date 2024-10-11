import 'package:app_feirinha/src/models/bebida.dart';
import 'package:app_feirinha/src/service/bebida_service.dart';
import 'package:flutter/material.dart';

class HomeBebida extends StatefulWidget {
  const HomeBebida({super.key});

  @override
  State<HomeBebida> createState() => _HomeBebidaState();
}

class _HomeBebidaState extends State<HomeBebida> {
  late Future<List<Bebida>> futureBebidas;
/*
A palavra-chave late em Dart é usada para declarar uma variável que será inicializada mais tarde, ou seja, não no momento de sua declaração, mas antes de ser acessada pela primeira vez. Isso é útil quando você tem certeza de que a variável será inicializada antes de ser usada, mas não pode inicializá-la imediatamente, por exemplo, durante a criação de uma classe ou em métodos assíncronos.
*/


  @override
  void initState() {
    super.initState();
    futureBebidas = BebidaService().fetchBebidas();
  }


  // Função para separar os Bebidas por categoria
  Map<String, List<Bebida>> agruparBebidasPorCategoria(List<Bebida> Bebidas) {
    Map<String, List<Bebida>> categorias = {};
    for (var Bebida in Bebidas) {
      if (!categorias.containsKey(Bebida.categoria)) {
        categorias[Bebida.categoria] = [];
      }
      categorias[Bebida.categoria]!.add(Bebida);
    }
    return categorias;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bebidas da Feirinha'),
      ),
      body: FutureBuilder<List<Bebida>>(
        future: futureBebidas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar Bebidas'));
          } else if (snapshot.hasData) {
            Map<String, List<Bebida>> BebidasPorCategoria = agruparBebidasPorCategoria(snapshot.data!);


            return ListView(
              children: BebidasPorCategoria.keys.map((String categoria) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        categoria,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      children: BebidasPorCategoria[categoria]!.map((Bebida Bebida) {
                        return Card(
                          child: ListTile(
                            leading: Image.network(Bebida.imagemUrl), // Exibe a imagem do Bebida
                            title: Text(Bebida.nome),
                            subtitle: Text('Preço: R\$${Bebida.preco.toStringAsFixed(2)}'),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              }).toList(),
            );
          } else {
            return Center(child: Text('Nenhum Bebida encontrado'));
          }
        },
      ),
    );
  }
}
