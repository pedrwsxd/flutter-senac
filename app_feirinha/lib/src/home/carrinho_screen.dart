
import 'package:app_feirinha/src/models/produto.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CarrinhoScreen extends StatelessWidget {
  final Map<Produto, int> carrinho;
  CarrinhoScreen({required this.carrinho});

  // Função para calcular o total dos produtos no carrinho
  double calcularTotal() {
    return carrinho.entries.fold(0.0, (total, entry) {
      Produto produto = entry.key;
      int quantidade = entry.value;
      return total + (produto.preco * quantidade);
    });
  }

  // Função para enviar o pedido via WhatsApp
  void enviarPedidoViaWhatsApp(BuildContext context) async {
    String mensagem = "Olá, gostaria de fazer um pedido:\n";
    carrinho.forEach((produto, quantidade){

    mensagem += "${produto.nome} - R\$${calcularTotal().toStringAsFixed(2)} X $quantidade\n";
    });

    mensagem += "Total: R\$${calcularTotal().toStringAsFixed(2)}";

    String url =
        "https://wa.me/5521964745484?text=${Uri.encodeComponent(mensagem)}";
    // observe que o número acima é o número do whatsapp para envio dos pedidos

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrlString(url);
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
                      Produto produto = carrinho.keys.elementAt(index);
                      int quantidade = carrinho[produto]!;
                      return ListTile(
                        leading: Image.network(produto.imagemUrl),
                        title: Text(produto.nome),
                        subtitle: Text(
                            'Preço: R\$${produto.preco.toStringAsFixed(2)} x $quantidade'),
                            trailing: Text('Subtotal: R\$${(produto.preco * quantidade).toStringAsFixed(2)}'),
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
