// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cronograma_receitas/modelos/erro_personalizado.dart';
import 'package:app_cronograma_receitas/repositorios/autenticacao.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final RepositorioAutenticacao repositorioAutenticacao;

  SigninCubit(
    this.repositorioAutenticacao,
  ) : super(SigninState.inicial());

  Future<void> signin({
    required String email,
    required String senha,
  }) async {
    emit(
      state.copyWith(statusSignIn: StatusSignIn.submetendo),
    );

    try {
      await repositorioAutenticacao.signin(
        email: email,
        senha: senha,
      );

      emit(
        state.copyWith(
          statusSignIn: StatusSignIn.sucesso,
        ),
      );
    } on ErroPersonalizado catch (e) {
      emit(
        state.copyWith(
          statusSignIn: StatusSignIn.erro,
          erro: e,
        ),
      );
    }
  }

  Future<void> resetarSenha({
    required String email,
  }) async {
    emit(
      state.copyWith(statusSignIn: StatusSignIn.submetendo),
    );

    try {
      await repositorioAutenticacao.resetarSenha(
        email: email,
      );

      emit(
        state.copyWith(
          statusSignIn: StatusSignIn.sucesso,
        ),
      );
    } on ErroPersonalizado catch (e) {
      emit(
        state.copyWith(
          statusSignIn: StatusSignIn.erro,
          erro: e,
        ),
      );
    }
  }
}
