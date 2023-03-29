import 'package:flutter/material.dart';

void mostrarSnackbar(BuildContext context, String mensagem) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(mensagem),
    ),
  );
}
