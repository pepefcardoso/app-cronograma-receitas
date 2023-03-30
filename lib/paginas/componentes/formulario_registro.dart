import 'package:app_cronograma_receitas/blocs/sign_up/signup_cubit.dart';
import 'package:app_cronograma_receitas/paginas/componentes/botao_personalizado.dart';
import 'package:app_cronograma_receitas/paginas/componentes/campo_texto.dart';
import 'package:app_cronograma_receitas/utils/dialogo_erro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormularioRegistroUsuario extends StatefulWidget {
  const FormularioRegistroUsuario({super.key});

  @override
  State<FormularioRegistroUsuario> createState() =>
      FormularioRegistroUsuarioState();
}

class FormularioRegistroUsuarioState extends State<FormularioRegistroUsuario> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _senhaController = TextEditingController();
  late String? _email, _senha;

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    context.read<SignupCubit>().signup(
          email: _email!,
          senha: _senha!,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state.statusSignUp == StatusSignUp.erro) {
          dialogoErro(context, state.erro);
        }
      },
      builder: (context, state) {
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

              //Campo de senha
              CampoTexto(
                controller: _senhaController,
                nomeCampo: 'Senha',
                icone: const Icon(Icons.lock),
                onSaved: (String? value) {
                  _senha = value;
                },
                tamanhoMinimo: 8,
                ehSenha: true,
              ),

              const SizedBox(height: 20.0),

              //Campo de confirmação de senha
              TextFormField(
                obscureText: true,
                autocorrect: false,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: "Confirme a Senha",
                  prefixIcon: const Icon(Icons.lock),
                ),
                validator: (String? value) {
                  if (_senhaController.text != value) {
                    return 'As senhas não conferem';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20.0),

              //Botão de submit
              BotaoPersonalizado(
                onPressed: state.statusSignUp == StatusSignUp.submetendo
                    ? () {}
                    : _submit,
                corPrincipal: Colors.white,
                texto: state.statusSignUp == StatusSignUp.submetendo
                    ? 'Carregando...'
                    : 'Cadastre-se',
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
