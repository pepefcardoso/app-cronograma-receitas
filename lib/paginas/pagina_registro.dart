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
          return SafeArea(
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
                      child: FormularioRegistroUsuario(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
