import 'package:app_cronograma_receitas/paginas/componentes/botao_personalizado.dart';
import 'package:flutter/material.dart';

class LoginOuCadastro extends StatelessWidget {
  const LoginOuCadastro({
    required this.textoBotao1,
    required this.onPressed1,
    required this.textoBotao2,
    required this.onPressed2,
    super.key,
  });

  final String textoBotao1;
  final Function() onPressed1;
  final String textoBotao2;
  final Function() onPressed2;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BotaoPersonalizado(
          onPressed: onPressed1,
          texto: textoBotao1,
          corPrincipal: Colors.white,
          corBorda: const Color.fromRGBO(227, 23, 10, 1),
          cortexto: Colors.black,
        ),
        const SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Expanded(
              child: Divider(
                color: Colors.white,
                indent: 20.0,
                endIndent: 10.0,
                thickness: 1.2,
              ),
            ),
            Text(
              'ou',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.white,
                indent: 10.0,
                endIndent: 20.0,
                thickness: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15.0),
        BotaoPersonalizado(
          onPressed: onPressed2,
          texto: textoBotao2,
          corPrincipal: const Color.fromRGBO(227, 23, 10, 1),
          corBorda: Colors.white,
          cortexto: Colors.white,
        ),
      ],
    );
  }
}
