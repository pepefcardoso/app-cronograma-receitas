import 'package:flutter/material.dart';

class BotaoTextoPersonalizado extends StatelessWidget {
  const BotaoTextoPersonalizado({
    required this.onPressed,
    required this.texto,
    super.key,
  });

  final Function() onPressed;
  final Text texto;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: texto,
    );
  }
}
