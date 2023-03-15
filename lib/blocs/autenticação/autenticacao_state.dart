part of 'autenticacao_bloc.dart';

enum StatusAutenticacao {
  desconhecido,
  autenticado,
  desautenticado,
}

class AutenticacaoState extends Equatable {
  final StatusAutenticacao statusAutenticacao;
  final fb_auth.User? usuario;
  const AutenticacaoState({
    required this.statusAutenticacao,
    this.usuario,
  });

  factory AutenticacaoState.desconhecido() {
    return const AutenticacaoState(
      statusAutenticacao: StatusAutenticacao.desconhecido,
    );
  }

  @override
  List<Object?> get props => [
        statusAutenticacao,
        usuario,
      ];

  @override
  bool get stringify => true;

  AutenticacaoState copyWith({
    StatusAutenticacao? statusAutenticacao,
    fb_auth.User? usuario,
  }) {
    return AutenticacaoState(
      statusAutenticacao: statusAutenticacao ?? this.statusAutenticacao,
      usuario: usuario ?? this.usuario,
    );
  }
}
