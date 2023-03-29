import 'package:app_cronograma_receitas/blocs/sign_up/signup_cubit.dart';
import 'package:app_cronograma_receitas/paginas/componentes/formulario_registro.dart';
import 'package:app_cronograma_receitas/paginas/componentes/marca_do_app.dart';
import 'package:app_cronograma_receitas/paginas/componentes/rodape_login_signup.dart';
import 'package:app_cronograma_receitas/paginas/componentes/slider_imagens.dart';
import 'package:app_cronograma_receitas/utils/dialogo_erro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginaRegistro extends StatefulWidget {
  static const String nomeRota = '/registro';

  const PaginaRegistro({super.key});

  @override
  State<PaginaRegistro> createState() => _PaginaRegistroState();
}

class _PaginaRegistroState extends State<PaginaRegistro> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.statusSignUp == StatusSignUp.erro) {
            dialogoErro(context, state.erro);
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                      //Marca do app
                      const Expanded(
                        flex: 1,
                        child: MarcaDoApp(),
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
                                "Cadastre-se",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            SizedBox(height: 25.0),

                            //Formulário de Registro
                            FormularioRegistroUsuario(),
                          ],
                        ),
                      ),

                      //Botão para a página de login
                      Expanded(
                        flex: 1,
                        child: RodapeLoginSignup(
                          textoMensagem: "Já é membro?",
                          textoBotao: "Entre aqui",
                          onPressed:
                              state.statusSignUp == StatusSignUp.submetendo
                                  ? () {}
                                  : () {
                                      Navigator.pop(context);
                                    },
                          corTexto: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
