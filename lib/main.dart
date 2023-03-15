import 'package:app_cronograma_receitas/blocs/autentica%C3%A7%C3%A3o/autenticacao_bloc.dart';
import 'package:app_cronograma_receitas/blocs/perfil/perfil_cubit.dart';
import 'package:app_cronograma_receitas/blocs/sign_in/signin_cubit.dart';
import 'package:app_cronograma_receitas/blocs/sign_up/signup_cubit.dart';
import 'package:app_cronograma_receitas/paginas/pagina_inicial.dart';
import 'package:app_cronograma_receitas/paginas/pagina_login.dart';
import 'package:app_cronograma_receitas/paginas/pagina_perfil.dart';
import 'package:app_cronograma_receitas/paginas/pagina_registro.dart';
import 'package:app_cronograma_receitas/paginas/pagina_splash.dart';
import 'package:app_cronograma_receitas/repositorios/autenticacao.dart';
import 'package:app_cronograma_receitas/repositorios/perfil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RepositorioAutenticacao>(
          create: (context) => RepositorioAutenticacao(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
        RepositoryProvider<RepositorioPerfil>(
          create: (context) => RepositorioPerfil(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AutenticacaoBloc>(
            create: (context) => AutenticacaoBloc(
              context.read<RepositorioAutenticacao>(),
            ),
          ),
          BlocProvider<SigninCubit>(
            create: (context) => SigninCubit(
              context.read<RepositorioAutenticacao>(),
            ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(
              context.read<RepositorioAutenticacao>(),
            ),
          ),
          BlocProvider<PerfilCubit>(
            create: (context) => PerfilCubit(
              repositorioPerfil: context.read<RepositorioPerfil>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Firebase Auth',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.deepOrange),
          home: const PaginaSplash(),
          routes: {
            PaginaInicial.nomeRota: (context) => const PaginaInicial(),
            PaginaPerfil.nomeRota: (context) => const PaginaPerfil(),
            PaginaLogin.nomeRota: (context) => const PaginaLogin(),
            PaginaRegistro.nomeRota: (context) => const PaginaRegistro(),
          },
        ),
      ),
    );
  }
}
