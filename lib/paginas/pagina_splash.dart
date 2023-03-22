import 'package:app_cronograma_receitas/blocs/autentica%C3%A7%C3%A3o/autenticacao_bloc.dart';
import 'package:app_cronograma_receitas/paginas/pagina_home.dart';
import 'package:app_cronograma_receitas/paginas/pagina_inicial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginaSplash extends StatelessWidget {
  static const String routeName = '/';

  const PaginaSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AutenticacaoBloc, AutenticacaoState>(
      listener: (context, state) {
        if (state.statusAutenticacao == StatusAutenticacao.desautenticado) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            PaginaInicial.nomeRota,
            (route) {
              return route.settings.name ==
                      ModalRoute.of(context)!.settings.name
                  ? true
                  : false;
            },
          );
        } else if (state.statusAutenticacao == StatusAutenticacao.autenticado) {
          Navigator.pushNamed(context, PaginaHome.nomeRota);
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
