import 'package:app_cronograma_receitas/blocs/autenticacao/autenticacao_bloc.dart';
import 'package:app_cronograma_receitas/blocs/perfil/perfil_cubit.dart';
import 'package:app_cronograma_receitas/paginas/componentes/formulario_perfil.dart';
import 'package:app_cronograma_receitas/utils/dialogo_erro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginaPerfil extends StatefulWidget {
  static const String nomeRota = '/perfil';

  const PaginaPerfil({super.key});

  @override
  State<PaginaPerfil> createState() => _PaginaPerfil();
}

class _PaginaPerfil extends State<PaginaPerfil> {
  @override
  void initState() {
    super.initState();
    _buscaPerfil();
  }

  void _buscaPerfil() {
    final String uid = context.read<AutenticacaoBloc>().state.usuario!.uid;

    context.read<PerfilCubit>().buscaPerfil(uid: uid);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(227, 23, 10, 1),
        body: BlocConsumer<PerfilCubit, PerfilState>(
          listener: (context, state) {
            if (state.statusPerfil == StatusPerfil.erro) {
              dialogoErro(context, state.erro);
            } else if (state.statusPerfil == StatusPerfil.atualizado) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Usuário atualizado com sucesso!",
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.statusPerfil == StatusPerfil.inicial) {
              return Container();
            } else if (state.statusPerfil == StatusPerfil.carregando) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.statusPerfil == StatusPerfil.erro) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.error,
                      color: Colors.white,
                      size: 100.0,
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Aconteceu um erro!\nTente novamente por favor!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            }
            return SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.keyboard_return),
                              color: Colors.white,
                              iconSize: 35.0,
                            ),
                            const SizedBox(width: 15.0),
                            const Text(
                              "Perfil",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: FormularioPerfil(
                            usuarioPadrao: state.usuario,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                    ],
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
