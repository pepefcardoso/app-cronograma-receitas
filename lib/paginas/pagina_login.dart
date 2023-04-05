import 'package:app_cronograma_receitas/paginas/componentes/formulario_login.dart';
import 'package:app_cronograma_receitas/paginas/componentes/marca_do_app.dart';
import 'package:app_cronograma_receitas/paginas/componentes/slider_imagens.dart';
import 'package:flutter/material.dart';

class PaginaLogin extends StatefulWidget {
  static const String nomeRota = '/login';

  const PaginaLogin({super.key});

  @override
  State<PaginaLogin> createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: const Color.fromRGBO(227, 23, 10, 1),
            body: Column(
              children: const [
                //Cabeçalho com a marca
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 25.0,
                    ),
                    child: MarcaDoApp(),
                  ),
                ),

                //Slider com imagens de marmitas
                SizedBox(height: 30.0),

                //Slider com imagens de marmitas
                SliderDeImagens(),

                SizedBox(height: 30.0),

                //Formulário de login
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: FormularioLogin(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
