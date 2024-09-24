import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp(
    title: 'app Hello Word!',
    valor: 80,
  ));
}

class MyApp extends StatelessWidget {
  final String title;
  final int valor;
  const MyApp({super.key, this.title = '', this.valor = 0});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 255, 21),
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'O valor é: $valor',
                    //estilo
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 255, 255, 255),
                      backgroundColor: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'O valor é: Hello Word!',
                    //estilo
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 255, 255, 255),
                      backgroundColor: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [ 
            BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
            
          ),
          
          
        ],
        ),
      ),
    );
  }
}
