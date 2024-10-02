import 'package:flutter/material.dart';

class Media extends StatefulWidget {
  const Media({super.key});

  @override
  State<Media> createState() => _MediaState();
}

class _MediaState extends State<Media> {
  TextEditingController nomeControler = TextEditingController();
  TextEditingController nota1Controler = TextEditingController();
  TextEditingController nota2Controler = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String infoText = "Situação:";

  void resetFields() {
    nomeControler.text = "";
    nota1Controler.text = "";
    nota2Controler.text = "";
    setState(() {
      formKey = GlobalKey<FormState>();
    });
  }

  void calculate() {
    setState(() {
      
      String nome = nomeControler.text;

      double nota1 = double.parse(nota1Controler.text);

      double nota2 = double.parse(nota2Controler.text);

      double media = (nota1 + nota2) / 2;

      if (media >= 6) {
        infoText =
            "Aluno: ${nome}. Situação: aprovado (${media.toStringAsPrecision(2)})";
      } else {
        infoText =
            "Aluno: ${nome}. Situação: reprovado (${media.toStringAsPrecision(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calcular Média",
          style: TextStyle(color: Colors.white),
        ),
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
                Icons.co_present_outlined,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Nome",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
                controller: nomeControler,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira o nome do aluno!";
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Nota 1",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
                controller: nota1Controler,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira a nota 1!";
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Nota 2",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
                controller: nota2Controler,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira a nota 2!";
                  }
                  return null;
                },
              ),
              Text(
                infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: // botão
            Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: SizedBox(
            height: 60.0,
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  calculate();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                "VERIFICAR",
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
