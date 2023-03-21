import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  final String id;
  final String nome;
  final String email;
  final DateTime dataNascimento;

  const Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.dataNascimento,
  });

  factory Usuario.fromDoc(DocumentSnapshot docUsuario) {
    final dadosUsuario = docUsuario.data() as Map<String, dynamic>?;

    return Usuario(
      id: docUsuario.id,
      nome: dadosUsuario!['name'],
      email: dadosUsuario['email'],
      dataNascimento: dadosUsuario['dataNascimento'].toDate(),
    );
  }

  factory Usuario.initialUser() {
    return Usuario(
      id: '',
      nome: '',
      email: '',
      dataNascimento: DateTime(2000),
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      nome,
      email,
      dataNascimento,
    ];
  }

  @override
  bool get stringify => true;
}
