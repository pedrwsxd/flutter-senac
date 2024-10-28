import 'dart:convert';

import 'package:app_foodtruck/src/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String apiUrl = 'http://localhost:8080'; // URL base da API

  // Função para realizar o login
  Future<void> login(String email, String senha, BuildContext context) async {
    final url = Uri.parse('$apiUrl/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'senha': senha}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String token = responseData['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro no login: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao conectar à API: $e')),
      );
    }
  }

  // Função para registrar um novo usuário
  Future<void> register(String email, String senha, BuildContext context) async {
    final url = Uri.parse('$apiUrl/auth/register'); // URL para a API de registro

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'senha': senha}),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário cadastrado com sucesso!')),
        );
        Navigator.pop(context); // Volta para a tela anterior após o cadastro
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro no cadastro: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao conectar à API: $e')),
      );
    }
  }

  // Função para realizar o logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Remove o token do SharedPreferences
  }

  // Função para verificar se o usuário está autenticado
  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null; // Retorna true se o token existir
  }

  // Função para obter os roles do usuário a partir do token JWT
  Future<List<String>> getUserRoles() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      return []; // Retorna uma lista vazia se não houver token
    }

    try {
      // Decodifica o token JWT
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      // Obtém a lista de roles
      List<dynamic> roles = payload['roles'];

      // Converte a lista de roles para uma lista de strings
      return roles.cast<String>();
    } catch (e) {
      print("Erro ao decodificar token: $e");
      return []; // Retorna uma lista vazia em caso de erro
    }
  }

  // Função para verificar se o usuário tem a role de administrador
  Future<bool> isAdmin() async {
    final roles = await getUserRoles();
    return roles.contains('ROLE_ADMIN');
  }

  // Função para obter o ID do usuário a partir do token JWT
  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      return null; // Retorna null se não houver token
    }

    try {
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      return payload['id'];
    } catch (e) {
      print("Erro ao decodificar token: $e");
      return null; // Retorna null em caso de erro
    }
  }
}