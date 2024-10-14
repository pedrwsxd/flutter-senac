import 'package:app_feirinha/src/models/produto.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class CarrinhoScreen extends StatelessWidget {
  final List<Produto> carrinho;


  CarrinhoScreen({required this.carrinho});


  // Função para calcular o total dos produtos no carrinho
  double calcularTotal() {
    return carrinho.fold(0.0, (total, produto) => total + produto.preco);
  }


  // Função para enviar o pedido via WhatsApp
  void enviarPedidoViaWhatsApp(BuildContext context) async {
    String mensagem = "Olá, gostaria de fazer um pedido:\n";
    for (var produto in carrinho) {
      mensagem += "${produto.nome} - R\$${produto.preco.toStringAsFixed(2)}\n";
    }
    mensagem += "Total: R\$${calcularTotal().toStringAsFixed(2)}";


    String url =
        "https://wa.me/5521997775786?text=${Uri.encodeComponent(mensagem)}";
	// observe que o número acima é o número do whatsapp para envio dos pedidos


    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível abrir o WhatsApp')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de Compras'),
      ),
      body: carrinho.isEmpty
          ? Center(child: Text('Nenhum produto no carrinho'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: carrinho.length,
                    itemBuilder: (context, index) {
                      Produto produto = carrinho[index];
                      return ListTile(
                        leading: Image.network(produto.imagemUrl),
                        title: Text(produto.nome),
                        subtitle: Text(
                            'Preço: R\$${produto.preco.toStringAsFixed(2)}'),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Total: R\$${calcularTotal().toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          enviarPedidoViaWhatsApp(context);
                        },
                        child: Text('Enviar Pedido via WhatsApp'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}


