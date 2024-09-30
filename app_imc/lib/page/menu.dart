// Crie um steteless chamado Opções

import 'package:app_imc/main.dart';
import 'package:app_imc/page/sobre.dart';
import 'package:flutter/material.dart';

class Opcoes extends StatelessWidget {
  const Opcoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Aula Flutter', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              leading: Icon(Icons.calculate, color: Colors.green,),
              title: const Text(
                'Calculadora IMC',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.green,),
              title: const Text('Sobre', style: TextStyle(color: Colors.green),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Sobre(),
                  ),
                );
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.close, color: Colors.green,),
              title: const Text('Fechar', style: TextStyle(color: Colors.green),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                );
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ), // Populate the Drawer in the next step.
      ),
    );
  }
}
