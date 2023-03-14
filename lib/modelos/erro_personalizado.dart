import 'package:equatable/equatable.dart';

class ErroPersonalizado extends Equatable {
  final String codigo;
  final String mensagem;
  final String plugin;

  const ErroPersonalizado({
    this.codigo = '',
    this.mensagem = '',
    this.plugin = '',
  });

  @override
  List<Object> get props => [
        codigo,
        mensagem,
        plugin,
      ];

  @override
  bool get stringify => true;
}
