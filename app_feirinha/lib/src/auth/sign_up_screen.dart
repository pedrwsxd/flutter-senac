import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_feirinha/src/auth/sign_in_screen.dart';
import 'package:app_feirinha/src/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatelessWidget {
  // Controladores de texto para capturar os valores digitados
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  // Função para criar um novo usuário
  Future<void> registerUser(String email, String senha, BuildContext context) async {
    final url = Uri.parse('http://10.0.2.2:8080/user/register'); // URL para a API de registro

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'senha': senha}),
      );

      if (response.statusCode == 201) {
        // Cadastro bem-sucedido
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário cadastrado com sucesso!')),
        );
        Navigator.pop(context); // Volta para a tela anterior após o cadastro
      } else {
        // Erro no cadastro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro no cadastro: ${response.body}')),
        );
      }
    } catch (e) {
      // Erro de conexão com a API
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao conectar à API: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
      ),
      backgroundColor: Colors.green,
      body: Column(
        children: [
          Expanded(
            child: Column(
              // alinhamento vertical
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 40,
                    ),
                    children: [
                      TextSpan(
                        text: 'Feir',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'inha',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // categorias

                SizedBox(
                  height: 50,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                        fontSize: 25,
                        fontFamily: 'Horizon',
                        color: Colors.white),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        RotateAnimatedText('Frutas'),
                        RotateAnimatedText('Legumes'),
                        RotateAnimatedText('Verduras'),
                        RotateAnimatedText('Temperos'),
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 40,
              ),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45),
                  )),
              child: Column(
                children: [
                  //Email
                  CustomTextField(
                    icon: Icons.email,
                    label: 'Email',
                    controller: emailController,
                  ),
                  //Senha
                  CustomTextField(
                    icon: Icons.lock,
                    label: 'Senha',
                    isSecret: true,
                    controller: senhaController,
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {
                        // Captura os valores dos campos de email e senha
                        String email = emailController.text.trim();
                        String senha = senhaController.text.trim();
                        registerUser(email, senha, context);
                        
                        
                      },
                      child: const Text(
                        'Cadastrar',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey.withAlpha(90),
                          thickness: 2,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text('Ou'),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey.withAlpha(90),
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                  // Botão de cadastro
                  // Botão com linhas de borda
                  SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      //formatação do botão
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        side: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                        );
                      },
                      child: const Text('Já sou cadastrado'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

