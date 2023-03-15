// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cronograma_receitas/modelos/erro_personalizado.dart';
import 'package:app_cronograma_receitas/repositorios/autenticacao.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final RepositorioAutenticacao repositorioAutenticacao;

  SignupCubit(
    this.repositorioAutenticacao,
  ) : super(SignupState.inicial());

  Future<void> signup({
    required String nome,
    required String email,
    required String senha,
    required DateTime dataNascimento,
  }) async {
    emit(
      state.copyWith(statusSignUp: StatusSignUp.submetendo),
    );

    try {
      await repositorioAutenticacao.signup(
        nome: nome,
        email: email,
        senha: senha,
        dataNascimento: dataNascimento,
      );

      emit(
        state.copyWith(
          statusSignUp: StatusSignUp.sucesso,
        ),
      );
    } on ErroPersonalizado catch (e) {
      emit(
        state.copyWith(
          statusSignUp: StatusSignUp.erro,
          erro: e,
        ),
      );
    }
  }
}
