import 'package:flutter/material.dart';

class BotaoPersonalizado extends StatelessWidget {
  const BotaoPersonalizado({
    required this.onPressed,
    required this.corPrincipal,
    required this.texto,
    required this.corBorda,
    required this.cortexto,
    super.key,
  });

  final Function() onPressed;
  final Color? corPrincipal;
  final String texto;
  final Color? corBorda;
  final Color? cortexto;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        decoration: BoxDecoration(
          color: corPrincipal,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: corBorda ?? Colors.white,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            texto,
            style: TextStyle(
              color: cortexto,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
