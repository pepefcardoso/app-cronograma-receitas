import 'package:app_cronograma_receitas/blocs/autenticacao/autenticacao_bloc.dart';
import 'package:app_cronograma_receitas/paginas/componentes/item_menu.dart';
import 'package:app_cronograma_receitas/paginas/componentes/marca_do_app.dart';
import 'package:app_cronograma_receitas/paginas/pagina_perfil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginaMenuInicial extends StatefulWidget {
  static const String nomeRota = '/menu_inicial';

  const PaginaMenuInicial({super.key});

  @override
  State<PaginaMenuInicial> createState() => _PaginaMenuInicial();
}

class _PaginaMenuInicial extends State<PaginaMenuInicial> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(227, 23, 10, 1),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        const MarcaDoApp(),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              PaginaPerfil.nomeRota,
                            );
                          },
                          icon: const Icon(Icons.account_circle),
                          color: Colors.white,
                          iconSize: 35.0,
                        ),
                        IconButton(
                          onPressed: () {
                            context
                                .read<AutenticacaoBloc>()
                                .add(SolicitouSignOutEvent());
                          },
                          icon: const Icon(Icons.exit_to_app),
                          color: Colors.white,
                          iconSize: 35.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Expanded(
                    flex: 9,
                    child: ListView(
                      children: const [
                        ItemMenu(
                            nome: "Receitas",
                            imagem: 'assets/images/refeicao_amigos.jpg'),
                        SizedBox(height: 20.0),
                        ItemMenu(
                            nome: "Ingredientes",
                            imagem: 'assets/images/marmitas.jpg'),
                        SizedBox(height: 20.0),
                        ItemMenu(
                            nome: "Cronogramas",
                            imagem: 'assets/images/refeicao_amigos.jpg'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
