import 'package:flutter/material.dart';

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    required this.nome,
    required this.imagem,
    super.key,
  });

  final String nome;
  final String imagem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 20.0, // Soften the shaodw
              spreadRadius: 2.0,
              offset: Offset(0.0, 0.0),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.network(imagem, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
