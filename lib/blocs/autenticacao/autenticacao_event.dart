// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'autenticacao_bloc.dart';

abstract class AutenticacaoEvent extends Equatable {
  const AutenticacaoEvent();

  @override
  List<Object?> get props => [];
}

class EstadoAutenticacaoMudouEvent extends AutenticacaoEvent {
  final fb_auth.User? usuario;
  const EstadoAutenticacaoMudouEvent({
    this.usuario,
  });

  @override
  List<Object?> get props => [usuario];
}

class SolicitouSignOutEvent extends AutenticacaoEvent {}
