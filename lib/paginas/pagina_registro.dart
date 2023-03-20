import 'package:app_cronograma_receitas/blocs/sign_up/signup_cubit.dart';
import 'package:app_cronograma_receitas/paginas/componentes/campo_registro.dart';
import 'package:app_cronograma_receitas/utils/dialogo_erro.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginaRegistro extends StatefulWidget {
  static const String nomeRota = '/registro';

  const PaginaRegistro({super.key});

  @override
  State<PaginaRegistro> createState() => _PaginaRegistroState();
}

class _PaginaRegistroState extends State<PaginaRegistro> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _senhaController = TextEditingController();
  String? _nome, _email, _senha;
  // DateTime? _dataNascimento;

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    context.read<SignupCubit>().signup(
          nome: _nome!,
          email: _email!,
          senha: _senha!,
          dataNascimento: DateTime(2022),
        );
  }

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
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: ListView(
                    reverse: true,
                    shrinkWrap: true,
                    children: [
                      CampoRegistro(
                        nomeCampo: 'Nome',
                        icone: const Icon(Icons.account_box),
                        onSaved: (String? value) {
                          _nome = value;
                        },
                        tamanhoMinimo: 2,
                      ),
                      const SizedBox(height: 20.0),
                      CampoRegistro(
                        nomeCampo: 'Email',
                        icone: const Icon(Icons.email),
                        onSaved: (String? value) {
                          _email = value;
                        },
                        tamanhoMinimo: 10,
                        ehEmail: true,
                        modoTeclado: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20.0),
                      CampoRegistro(
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
                      CampoRegistro(
                        nomeCampo: 'Confirme a Senha',
                        icone: const Icon(Icons.lock),
                        tamanhoMinimo: 8,
                        ehSenha: true,
                        confirmacaoSenha: _senhaController.text,
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        onPressed: state.statusSignUp == StatusSignUp.submetendo
                            ? null
                            : _submit,
                        child: Text(
                            state.statusSignUp == StatusSignUp.submetendo
                                ? 'Carregando...'
                                : 'Cadastre-se'),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        onPressed: state.statusSignUp == StatusSignUp.submetendo
                            ? null
                            : () {
                                Navigator.pop(context);
                              },
                        child: const Text('Já é cadastrado? Entre Aqui!'),
                      ),
                    ].reversed.toList(),
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
