import 'package:app_cronograma_receitas/blocs/sign_in/signin_cubit.dart';
import 'package:app_cronograma_receitas/paginas/componentes/botao_personalizado.dart';
import 'package:app_cronograma_receitas/paginas/componentes/campo_texto.dart';
import 'package:app_cronograma_receitas/utils/dialogo_erro.dart';
import 'package:app_cronograma_receitas/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormularioEsqueceusenha extends StatefulWidget {
  const FormularioEsqueceusenha({super.key});

  @override
  State<FormularioEsqueceusenha> createState() =>
      FormularioEsqueceusenhaState();
}

class FormularioEsqueceusenhaState extends State<FormularioEsqueceusenha> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  late String? _email;

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    context.read<SigninCubit>().resetarSenha(
          email: _email!,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state.statusSignIn == StatusSignIn.erro) {
          dialogoErro(context, state.erro);
        } else if (state.statusSignIn == StatusSignIn.sucesso) {
          Navigator.of(context).pop();
          mostrarSnackbar(
            context,
            "Email enviado com sucesso!",
          );
        }
      },
      builder: (context, state) {
        //Formulário de login
        return Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: ListView(
            reverse: true,
            shrinkWrap: true,
            children: [
              //Campo de email

              CampoTexto(
                nomeCampo: 'Email',
                icone: const Icon(Icons.email),
                onSaved: (String? value) {
                  _email = value!.trim();
                },
                tamanhoMinimo: 10,
                ehEmail: true,
                modoTeclado: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20.0),

              //Botão de submit
              BotaoPersonalizado(
                onPressed: _submit,
                corPrincipal: Colors.white,
                texto: state.statusSignIn == StatusSignIn.submetendo
                    ? 'Carregando...'
                    : 'Resetar Senha',
                corBorda: Colors.white,
                cortexto: Colors.black,
              ),
            ].reversed.toList(),
          ),
        );
      },
    );
  }
}
