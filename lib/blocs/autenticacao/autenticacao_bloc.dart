// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter_bloc/flutter_bloc.dart';

import '/repositorios/autenticacao.dart';

part 'autenticacao_event.dart';
part 'autenticacao_state.dart';

class AutenticacaoBloc extends Bloc<AutenticacaoEvent, AutenticacaoState> {
  late final StreamSubscription autenticacaoSubscription;

  final RepositorioAutenticacao repositorioAutenticacao;

  AutenticacaoBloc(
    this.repositorioAutenticacao,
  ) : super(AutenticacaoState.desconhecido()) {
    autenticacaoSubscription = repositorioAutenticacao.user.listen(
      (fb_auth.User? user) {
        add(
          EstadoAutenticacaoMudouEvent(usuario: user),
        );
      },
    );
    on<EstadoAutenticacaoMudouEvent>((event, emit) {
      if (event.usuario != null) {
        emit(
          state.copyWith(
            statusAutenticacao: StatusAutenticacao.autenticado,
            usuario: event.usuario,
          ),
        );
      } else {
        emit(
          state.copyWith(
            statusAutenticacao: StatusAutenticacao.desautenticado,
            usuario: null,
          ),
        );
      }
    });

    on<SolicitouSignOutEvent>(
      (event, emit) async {
        await repositorioAutenticacao.signout();
      },
    );
  }
}
