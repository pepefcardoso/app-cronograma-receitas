import 'package:flutter/material.dart';

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({super.key});

  static const String nomeRota = '/login';

  @override
  State<PaginaLogin> createState() => _PaginaLogin();
}

class _PaginaLogin extends State<PaginaLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Column(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            color: Theme.of(context).colorScheme.primary,
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: Text(
                'Cronograma de Receitas',
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 45.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25.0,
              horizontal: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(
                  Icons.restaurant,
                  size: 40.0,
                ),
                Icon(
                  Icons.menu_book,
                  size: 40.0,
                ),
                Icon(
                  Icons.kitchen,
                  size: 40.0,
                ),
                Icon(
                  Icons.lunch_dining,
                  size: 40.0,
                ),
                Icon(
                  Icons.soup_kitchen,
                  size: 40.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
