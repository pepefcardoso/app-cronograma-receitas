import 'package:app_cronograma_receitas/paginas/componentes/formulario_esqueceu_senha.dart';
import 'package:app_cronograma_receitas/paginas/componentes/marca_do_app.dart';
import 'package:app_cronograma_receitas/paginas/componentes/slider_imagens.dart';
import 'package:flutter/material.dart';

class PaginaEsqueceuSenha extends StatefulWidget {
  static const String nomeRota = '/esqueceu_senha';

  const PaginaEsqueceuSenha({super.key});

  @override
  State<PaginaEsqueceuSenha> createState() => _PaginaEsqueceuSenhaState();
}

class _PaginaEsqueceuSenhaState extends State<PaginaEsqueceuSenha> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromRGBO(227, 23, 10, 1),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              child: Column(
                children: [
                  //Marca do app
                  const Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: MarcaDoApp(),
                    ),
                  ),
                  const Expanded(
                    flex: 4,
                    child: SliderDeImagens(),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: const [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Esqueci a Senha",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(height: 25.0),

                        //Formulário de Registro
                        FormularioEsqueceusenha(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
