import 'package:app_cronograma_receitas/blocs/sign_up/signup_cubit.dart';
import 'package:app_cronograma_receitas/paginas/componentes/botao_texto_personalizado.dart';
import 'package:app_cronograma_receitas/paginas/componentes/formulario_registro.dart';
import 'package:app_cronograma_receitas/paginas/componentes/marca_do_app.dart';
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
                child: Column(
                  children: [
                    //Marca do app
                    const Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25.0,
                        ),
                        child: MarcaDoApp(),
                      ),
                    ),

                    const Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text(
                            "Cadastre-se",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Formulário de Registro
                    const Expanded(
                      flex: 6,
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25.0,
                          ),
                          child: FormularioRegistroUsuario(),
                        ),
                      ),
                    ),

                    //Botão para a página de login
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Já é membro?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            BotaoTextoPersonalizado(
                              texto: const Text(
                                "Entre aqui",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed:
                                  state.statusSignUp == StatusSignUp.submetendo
                                      ? () {}
                                      : () {
                                          Navigator.pop(context);
                                        },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
