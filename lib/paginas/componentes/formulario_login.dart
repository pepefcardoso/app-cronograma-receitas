import 'package:app_cronograma_receitas/blocs/sign_in/signin_cubit.dart';
import 'package:app_cronograma_receitas/paginas/componentes/botao_personalizado.dart';
import 'package:app_cronograma_receitas/paginas/componentes/botao_texto_personalizado.dart';
import 'package:app_cronograma_receitas/paginas/componentes/campo_entrada.dart';
import 'package:app_cronograma_receitas/paginas/pagina_esqueceu_senha.dart';
import 'package:app_cronograma_receitas/utils/dialogo_erro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormularioLogin extends StatefulWidget {
  const FormularioLogin({super.key});

  @override
  State<FormularioLogin> createState() => _FormularioLoginState();
}

class _FormularioLoginState extends State<FormularioLogin> {
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
    return BlocConsumer<SigninCubit, SigninState>(
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
              Row(
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
                      onPressed: () {
                        Navigator.pushNamed(
                            context, PaginaEsqueceuSenha.nomeRota);
                      }),
                ],
              ),

              const SizedBox(height: 12.0),

//Botão Login
              BotaoPersonalizado(
                onPressed: _submit,
                corPrincipal: Colors.white,
                texto: state.statusSignIn == StatusSignIn.submetendo
                    ? 'Carregando...'
                    : 'Entrar',
                corBorda: Colors.white,
                cortexto: Colors.black,
              ),
            ],
          ),
        );
      },
    );
  }
}
