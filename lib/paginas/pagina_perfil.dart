import 'package:app_cronograma_receitas/blocs/autenticacao/autenticacao_bloc.dart';
import 'package:app_cronograma_receitas/blocs/perfil/perfil_cubit.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: BlocConsumer<PerfilCubit, PerfilState>(
        listener: (context, state) {
          if (state.statusPerfil == StatusPerfil.erro) {
            dialogoErro(context, state.erro);
          }
        },
        builder: (context, state) {
          if (state.statusPerfil == StatusPerfil.inicial) {
            return Container();
          } else if (state.statusPerfil == StatusPerfil.carregando) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.statusPerfil == StatusPerfil.erro) {
            return Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 100.0,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Ooops!\nTry again!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          }
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '-name: ${state.usuario.nome}',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        '-email: ${state.usuario.email}',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        '-data nascimento: ${state.usuario.dataNascimento.toString()}',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
