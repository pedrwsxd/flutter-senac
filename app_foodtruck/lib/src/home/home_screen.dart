import 'package:app_foodtruck/src/home/carrinho_screen.dart';
import 'package:app_foodtruck/src/models/produto.dart';
import 'package:app_foodtruck/src/service/produto_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Produto>> futureProdutos;
  Map<Produto, int> carrinho = {};

  @override
  void initState() {
    super.initState();
    futureProdutos = ProdutoService().fetchProdutos();
  }

  void adicionarAoCarrinho(Produto produto) {
    setState(() {
      if (carrinho.containsKey(produto)) {
        carrinho[produto] = carrinho[produto]! + 1;
      } else {
        carrinho[produto] = 1;
      }
    });
  }

  void removerDoCarrinho(Produto produto) {
    setState(() {
      if (carrinho.containsKey(produto) && carrinho[produto]! > 0) {
        carrinho[produto] = carrinho[produto]! - 1;
        if (carrinho[produto] == 0) {
          carrinho.remove(produto);
        }
      }
    });
  }

  Map<String, List<Produto>> agruparProdutosPorTipo(List<Produto> produtos) {
    Map<String, List<Produto>> tipos = {};
    for (var produto in produtos) {
      if (produto.tipo != null) {
        if (!tipos.containsKey(produto.tipo)) {
          tipos[produto.tipo] = [];
        }
        tipos[produto.tipo]!.add(produto);
      }
    }
    return tipos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos da IceCream Churros'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CarrinhoScreen(
                    carrinho: carrinho,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: FutureBuilder<List<Produto>>(
        future: futureProdutos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar produtos'));
          } else if (snapshot.hasData) {
            Map<String, List<Produto>> produtosPorTipo =
                agruparProdutosPorTipo(snapshot.data!);

            return ListView(
              children: produtosPorTipo.keys.map((String tipo) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        tipo,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      children: produtosPorTipo[tipo]!
                          .map((Produto produto) {
                        return Card(
                          child: ListTile(
                            leading: produto.imagemUrl != null
                                ? Image.network(produto.imagemUrl!)
                                : const Icon(Icons.image, size: 40),
                            title: Text(produto.nome),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Preço: R\$${produto.preco.toStringAsFixed(2)}'),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        removerDoCarrinho(produto);
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text(
                                      carrinho[produto]?.toString() ?? '0',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        adicionarAoCarrinho(produto);
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.add_shopping_cart),
                              onPressed: () {
                                adicionarAoCarrinho(produto);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${produto.nome} adicionado ao carrinho!'),
                                  ),
                                );
                              },
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
            return const Center(child: Text('Nenhum produto encontrado'));
          }
        },
      ),
    );
  }
}
