import 'package:app_cronograma_receitas/blocs/sign_in/signin_cubit.dart';
import 'package:app_cronograma_receitas/paginas/componentes/botao_texto_personalizado.dart';
import 'package:app_cronograma_receitas/paginas/componentes/botao_personalizado.dart';
import 'package:app_cronograma_receitas/paginas/componentes/campo_entrada.dart';
import 'package:app_cronograma_receitas/paginas/pagina_registro.dart';
import 'package:app_cronograma_receitas/utils/dialogo_erro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginaLogin extends StatefulWidget {
  static const String nomeRota = '/login';

  const PaginaLogin({super.key});

  @override
  State<PaginaLogin> createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _email, _senha;

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    context.read<SigninCubit>().signin(
          email: _email!,
          senha: _senha!,
        );
  }

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
              child: Column(
                children: [
                  //Logo e nome do app
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/panela_1.png",
                          height: 60,
                          width: 60,
                        ),
                        const SizedBox(width: 20.0),
                        const Text(
                          "Receitaria",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 44.0),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset("assets/images/refeicao_amigos.jpg"),
                    ),
                  ),

                  const SizedBox(height: 44.0),

                  //Texto de boas vindas
                  const Text(
                    "Seja bem vindo novamente :)",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),

                  const SizedBox(height: 28.0),

                  //Bloc do login
                  BlocConsumer<SigninCubit, SigninState>(
                    listener: (context, state) {
                      if (state.statusSignIn == StatusSignIn.erro) {
                        dialogoErro(context, state.erro);
                      }
                    },
                    builder: (context, state) {
                      //Formulário de login
                      return Form(
                        key: _formKey,
                        autovalidateMode: _autovalidateMode,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            //Input do Email
                            CampoEntrada(
                              nomeCampo: 'Email',
                              icone: const Icon(Icons.email),
                              onSaved: (String? value) {
                                _email = value!.trim();
                              },
                              tamanhoMinimo: 10,
                              ehEmail: true,
                              modoTeclado: TextInputType.emailAddress,
                            ),

                            const SizedBox(height: 15.0),

                            //Input da senha
                            CampoEntrada(
                              nomeCampo: 'Senha',
                              icone: const Icon(Icons.lock),
                              onSaved: (String? value) {
                                _senha = value;
                              },
                              tamanhoMinimo: 8,
                              ehSenha: true,
                            ),

                            //Botao Esqueceu a senha
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  BotaoTextoPersonalizado(
                                      texto: const Text(
                                        "Esqueceu a senha?",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      onPressed: () {}),
                                ],
                              ),
                            ),

                            const SizedBox(height: 12.0),

//Botão Login
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: BotaoPersonalizado(
                                onPressed: _submit,
                                corPrincipal: Colors.white,
                                texto: state.statusSignIn ==
                                        StatusSignIn.submetendo
                                    ? 'Carregando...'
                                    : 'Entrar',
                                corBorda: Colors.white,
                                cortexto: Colors.black,
                              ),
                            ),

                            const SizedBox(height: 60.0),

                            //Botão de cadastro
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Ainda não é membro?",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
                                  BotaoTextoPersonalizado(
                                      texto: const Text(
                                        "Cadastre-se aqui",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.popAndPushNamed(
                                            context, PaginaRegistro.nomeRota);
                                      }),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15.0),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
