import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_imc/page/menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Opcoes(), //Home()
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoControle = TextEditingController();
  TextEditingController alturaControle = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String infoText = "Informe seus dados";

  void resetFields() {
    pesoControle.text = "";
    alturaControle.text = "";
    setState(() {
      infoText = "Infome seus dados";
      formKey = GlobalKey<FormState>();
    });
  }

  void calculate() {
    setState(() {
      double peso = double.parse(pesoControle.text);

      double altura = double.parse(alturaControle.text) / 100;
      double imc = peso / (altura * altura);

      if (imc < 18.6) {
        infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        infoText = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        infoText = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        infoText = "Obesidade Grau 1 (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        infoText = "Obesidade Grau 2 (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        infoText = "Obesidade Grau 3 (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
              resetFields();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
                controller: pesoControle,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira seu Peso!";
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
                controller: alturaControle,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira sua Altura!";
                  }
                  return null;
                },
              ),
              //botão

              Text(
                infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
              ),

              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'Horizon',
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    RotateAnimatedText('FLAMENGO'),
                    RotateAnimatedText('O'),
                    RotateAnimatedText('MELHOR DO MUNDO'),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: // botão
            SizedBox(
          height: 10.0,
          child: ElevatedButton(
            // chamar agora uma função anonima
            onPressed: () {
              if (formKey.currentState!.validate()) {
                calculate();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text(
              "Calcular",
              style: TextStyle(color: Colors.white, fontSize: 25.0),
            ),
          ),
        ),
      ),
    );
  }
}
