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
    _buscaPerfil();
    super.initState();
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
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state.statusPerfil == StatusPerfil.carregando) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.statusPerfil == StatusPerfil.inicial) {
              return Container();
            }
            return SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.keyboard_return),
                            color: Colors.white,
                            iconSize: 35.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Perfil",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 25.0),
                            FormularioPerfil(
                              usuarioPadrao: state.usuario,
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      )
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
