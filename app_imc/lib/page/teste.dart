import 'package:flutter/material.dart';

class Testee extends StatelessWidget {
  const Testee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "LUGAR PARA TESTE",
            style: TextStyle(color: const Color.fromARGB(255, 88, 6, 0)),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Center(
              child: Text(
                "Hello Word",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}
