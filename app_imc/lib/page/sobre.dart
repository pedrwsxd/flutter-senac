import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  const Sobre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sobre App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ibm.jpg',
              width: 500,
              height: 500,
            ),
            Image.network(
              'https://img.freepik.com/fotos-gratis/por-do-sol-com-mar_74190-1012.jpg',
              width: 200,
              height: 200,
            ),
            const Text(
              "Senac - TI",
              style: TextStyle(color: Colors.green, fontSize: 40.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "Treinamento Flutter",
              style: TextStyle(color: Colors.green, fontSize: 30.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Desenvolvido por Pedro Henrick",
                  style: TextStyle(color: Colors.green, fontSize: 20.0),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  Icons.flutter_dash,
                  color: Colors.green,
                  size: 30.0,
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "30/09/2024",
              style: TextStyle(color: Colors.green, fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
