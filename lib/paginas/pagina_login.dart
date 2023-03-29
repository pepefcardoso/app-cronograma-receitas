import 'package:app_cronograma_receitas/paginas/componentes/formulario_login.dart';
import 'package:app_cronograma_receitas/paginas/componentes/marca_do_app.dart';
import 'package:app_cronograma_receitas/paginas/componentes/rodape_login_signup.dart';
import 'package:app_cronograma_receitas/paginas/componentes/slider_imagens.dart';
import 'package:app_cronograma_receitas/paginas/pagina_registro.dart';
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
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromRGBO(227, 23, 10, 1),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                ),
                child: Column(
                  children: [
                    //Cabeçalho com a marca
                    const Expanded(
                      flex: 1,
                      child: MarcaDoApp(),
                    ),

                    //Slider com imagens de marmitas
                    const Expanded(
                      flex: 4,
                      child: SliderDeImagens(),
                    ),

                    Expanded(
                      flex: 4,
                      child: Column(
                        children: const [
                          //Texto de boas vindas
                          Text(
                            "Seja bem vindo novamente :)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),

                          SizedBox(height: 20.0),

                          //Formulário de login
                          FormularioLogin(),
                        ],
                      ),
                    ),

                    //Rodapé com botão de cadastro
                    Expanded(
                      flex: 1,
                      child: RodapeLoginSignup(
                        textoMensagem: "Ainda não é membro?",
                        textoBotao: "Cadastre-se aqui",
                        onPressed: () {
                          Navigator.pushNamed(context, PaginaRegistro.nomeRota);
                        },
                        corTexto: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
