import 'package:flutter/material.dart';

void main() {
  //executar MyApp
  runApp(
    const MyApp(
      nome: 'Pedro',
    ),
  );
}

// criação do statefull
class MyApp extends StatefulWidget {
  // criar variável
  final String nome;
  const MyApp({super.key, this.nome = ''});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // uma variável que poderá ser alterada
  int salario = 12000;

  void aumentarSalario(int valor) {
    setState(() {
      salario = salario + valor;
    });
  }

  void diminuirSalario(int valor) {
    setState(() {
      salario = salario - valor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Aplicativo 2'),
          ),
          body: Center(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('O salário de ${widget.nome} é: $salario'),
                  ],
                ),
                
                Row(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        aumentarSalario(100);
                      },
                      child: const Icon(Icons.arrow_upward),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        diminuirSalario(50);
                      },
                      child: const Icon(Icons.arrow_downward),
                    ),
                    
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
