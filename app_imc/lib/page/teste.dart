import 'package:flutter/material.dart';

class Testee extends StatelessWidget {
  const Testee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("LUGAR PARA TESTE", style: TextStyle(color: Colors.red),), 
      backgroundColor: Colors.white60, 
      centerTitle: true,
      ),
    );
  }
}