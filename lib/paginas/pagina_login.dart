import 'package:app_cronograma_receitas/blocs/sign_in/signin_cubit.dart';
import 'package:app_cronograma_receitas/paginas/pagina_registro.dart';
import 'package:app_cronograma_receitas/utils/dialogo_erro.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
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
        child: BlocConsumer<SigninCubit, SigninState>(
          listener: (context, state) {
            if (state.statusSignIn == StatusSignIn.erro) {
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
                      shrinkWrap: true,
                      children: [
                        const Text(
                          'Receitaria',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 70.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Image.asset(
                          'assets/images/panela_1.png',
                          width: 300,
                          height: 300,
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email é obrigatório';
                            }
                            if (!isEmail(value.trim())) {
                              return 'Insira um email válido';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            _email = value;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'Senha',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Senha é obrigatório';
                            }
                            if (value.trim().length < 8) {
                              return 'Senha precisa ter pelo menos 8 caracteres';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            _senha = value;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            textStyle: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                          ),
                          onPressed:
                              state.statusSignIn == StatusSignIn.submetendo
                                  ? null
                                  : _submit,
                          child: Text(
                              state.statusSignIn == StatusSignIn.submetendo
                                  ? 'Carregando...'
                                  : 'Entrar'),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                            textStyle: const TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            state.statusSignIn == StatusSignIn.submetendo
                                ? null
                                : Navigator.pushNamed(
                                    context, PaginaRegistro.nomeRota);
                          },
                          child: const Text('Se inscreva aqui!'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
