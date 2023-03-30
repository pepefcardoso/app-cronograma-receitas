// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cronograma_receitas/modelos/erro_personalizado.dart';
import 'package:app_cronograma_receitas/modelos/usuario.dart';
import 'package:app_cronograma_receitas/repositorios/perfil.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'perfil_state.dart';

class PerfilCubit extends Cubit<PerfilState> {
  final RepositorioPerfil repositorioPerfil;

  PerfilCubit({
    required this.repositorioPerfil,
  }) : super(PerfilState.inicial());

  Future<void> buscaPerfil({required String uid}) async {
    emit(
      state.copyWith(
        statusPerfil: StatusPerfil.carregando,
      ),
    );

    try {
      final Usuario usuario = await repositorioPerfil.buscaPerfil(
        uid: uid,
      );
      emit(
        state.copyWith(
          statusPerfil: StatusPerfil.carregado,
          usuario: usuario,
        ),
      );
    } on ErroPersonalizado catch (e) {
      emit(
        state.copyWith(
          statusPerfil: StatusPerfil.erro,
          erro: e,
        ),
      );
    }
  }

  Future<void> atualizaPerfil({
    required String uid,
    required Map<String, dynamic> info,
  }) async {
    emit(
      state.copyWith(
        statusPerfil: StatusPerfil.carregando,
      ),
    );

    try {
      final Usuario usuario = await repositorioPerfil.atualizaPerfil(
        uid: uid,
        info: info,
      );
      emit(
        state.copyWith(
          statusPerfil: StatusPerfil.carregado,
          usuario: usuario,
        ),
      );
    } on ErroPersonalizado catch (e) {
      emit(
        state.copyWith(
          statusPerfil: StatusPerfil.erro,
          erro: e,
        ),
      );
    }
  }
}
