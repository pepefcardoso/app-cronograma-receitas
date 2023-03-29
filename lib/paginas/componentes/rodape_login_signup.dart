import 'package:app_cronograma_receitas/paginas/componentes/botao_texto_personalizado.dart';
import 'package:flutter/material.dart';

class RodapeLoginSignup extends StatelessWidget {
  const RodapeLoginSignup(
      {super.key,
      required this.textoMensagem,
      required this.textoBotao,
      required this.onPressed,
      required this.corTexto});

  final String textoMensagem;
  final String textoBotao;
  final Function() onPressed;
  final Color corTexto;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textoMensagem,
          style: TextStyle(
            color: corTexto,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(width: 5.0),
        BotaoTextoPersonalizado(
          texto: Text(
            textoBotao,
            style: TextStyle(
              color: corTexto,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
