import 'package:app_cronograma_receitas/paginas/componentes/login_ou_cadastro.dart';
import 'package:app_cronograma_receitas/paginas/pagina_login.dart';
import 'package:app_cronograma_receitas/paginas/pagina_registro.dart';
import 'package:flutter/material.dart';

class PaginaInicial extends StatefulWidget {
  static const String nomeRota = '/inicial';

  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicial();
}

class _PaginaInicial extends State<PaginaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(227, 23, 10, 1),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //Logo e nome do app
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/panela_1.png",
                  height: 60,
                  width: 60,
                ),
                const SizedBox(width: 20.0),
                const Text(
                  "Receitaria",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          //Imagem das marmitas
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset("assets/images/marmitas.jpg"),
            ),
          ),

          const SizedBox(height: 15.0),

          //Texto Explicativo do app
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Gerenciador de Receitas",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  "Um app para facilitar sua vida, ajudando você a cadastrar receitas e organizar seus cronogramas semanais de marmitas",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          //Widget para fazer login ou fazer cadastro
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
            ),
            child: LoginOuCadastro(
              textoBotao1: "Login",
              onPressed1: () {
                Navigator.popAndPushNamed(context, PaginaLogin.nomeRota);
              },
              textoBotao2: "Cadastre-se",
              onPressed2: () {
                Navigator.popAndPushNamed(context, PaginaRegistro.nomeRota);
              },
            ),
          ),
          const SizedBox(height: 50.0),
        ],
      )),
    );
  }
}
