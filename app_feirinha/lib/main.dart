import 'package:app_feirinha/src/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Feirinha',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SignInScreen(),
    );
  }
}

