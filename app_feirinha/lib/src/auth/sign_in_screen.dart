import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_feirinha/src/components/custom_text_field.dart';
import 'package:app_feirinha/src/home/home_screen.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  // Função para realizar o login
  Future<void> loginUser(
      String email, String senha, BuildContext context) async {
    final url = Uri.parse('http://10.0.2.2:8080/user/login'); // API de login

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'senha': senha}),
      );

      if (response.statusCode == 200) {
        // Login bem-sucedido
        //print('Login bem-sucedido: ${response.body}');
        // aqui você pode navegar para outra tela ou exibir uma mensagem de sucesso
        // Navegar para a nova tela HomeScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // login falhou
        //print('Erro no login: ${response.body}');
        // Mostre uma mensagem de erro ao usuário
        // exibir uma mensagem de erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro no login: ${response.body}')),
        );
      }
    } catch (e) {
      //print('Erro ao concectar à API: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao conectar à API: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // definição dos campos para usurario de senha
    TextEditingController emailController = TextEditingController();
    TextEditingController senhaController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada"),
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
            child: Expanded(
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
    
                          // Verifica se os campos estão preenchidos
                          if (email.isNotEmpty && senha.isNotEmpty) {
                            loginUser(email, senha, context);
                          } else {
                            print('Campos de email ou senha estão vazios.');
                            // Exibe uma mensagem para o usuário
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Preencha todos os campos!')),
                            );
                          }
                        },
                        child: const Text(
                          'Entrar',
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
                        onPressed: () {},
                        child: const Text('Criar conta'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
