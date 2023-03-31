part of 'perfil_cubit.dart';

enum StatusPerfil {
  inicial,
  carregando,
  carregado,
  atualizando,
  atualizado,
  erro,
}

class PerfilState extends Equatable {
  final StatusPerfil statusPerfil;
  final Usuario usuario;
  final ErroPersonalizado erro;

  const PerfilState({
    required this.statusPerfil,
    required this.usuario,
    required this.erro,
  });

  factory PerfilState.inicial() {
    return PerfilState(
      statusPerfil: StatusPerfil.inicial,
      usuario: Usuario.initialUser(),
      erro: const ErroPersonalizado(),
    );
  }

  @override
  List<Object> get props => [statusPerfil, usuario, erro];

  @override
  bool get stringify => true;

  PerfilState copyWith({
    StatusPerfil? statusPerfil,
    Usuario? usuario,
    ErroPersonalizado? erro,
  }) {
    return PerfilState(
      statusPerfil: statusPerfil ?? this.statusPerfil,
      usuario: usuario ?? this.usuario,
      erro: erro ?? this.erro,
    );
  }
}
