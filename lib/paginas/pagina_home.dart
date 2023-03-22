import 'package:app_cronograma_receitas/blocs/autentica%C3%A7%C3%A3o/autenticacao_bloc.dart';
import 'package:app_cronograma_receitas/paginas/pagina_perfil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginaHome extends StatefulWidget {
  static const String nomeRota = '/home';

  const PaginaHome({super.key});

  @override
  State<PaginaHome> createState() => _PaginaHome();
}

class _PaginaHome extends State<PaginaHome> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Home'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  PaginaPerfil.nomeRota,
                );
              },
              icon: const Icon(Icons.account_circle),
            ),
            IconButton(
              onPressed: () {
                context.read<AutenticacaoBloc>().add(SolicitouSignOutEvent());
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: const Center(
          child: Text('Inicial'),
        ),
      ),
    );
  }
}
