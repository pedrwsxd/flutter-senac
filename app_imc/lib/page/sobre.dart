import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  const Sobre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre App', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Text("Senac - TI", style: TextStyle(color: Colors.green, fontSize: 40.0),),
            
            SizedBox(height: 10.0,),
            
            Text("Treinamento Flutter", style: TextStyle(color: Colors.green, fontSize: 30.0),),
            
            SizedBox(height: 10.0,),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Desenvolvido por Pedro Henrick", style: TextStyle(color: Colors.green, fontSize: 20.0),),
                SizedBox(width: 10.0,),
                Icon(Icons.flutter_dash, color: Colors.green, size: 30.0,),
              ],
              
            ),
            
            SizedBox(height: 10.0,),
            
            Text("30/09/2024", style: TextStyle(color: Colors.green, fontSize: 20.0),),
          ],
        ),
      ),
      
    );
  }
}
