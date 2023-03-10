import 'package:app_cronograma_receitas/paginas/pagina_login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cronograma de Receitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFC41E3A),
          primaryContainer: Color(0xFFEE4B2B),
          secondary: Color(0xFFFFAC1C),
          secondaryContainer: Color(0xFFEADDCA),
        ),
      ),
      home: const PaginaLogin(),
      routes: {
        PaginaLogin.nomeRota: (context) => const PaginaLogin(),
      },
    );
  }
}
