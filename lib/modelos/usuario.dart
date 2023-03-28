import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  final String id;
  final String? nome;
  final String email;
  final DateTime? dataNascimento;
  final String? fotoPerfil;

  const Usuario({
    required this.id,
    this.nome,
    required this.email,
    this.dataNascimento,
    this.fotoPerfil,
  });

  factory Usuario.fromDoc(DocumentSnapshot docUsuario) {
    final dadosUsuario = docUsuario.data() as Map<String, dynamic>?;

    return Usuario(
      id: docUsuario.id,
      nome: dadosUsuario!['name'],
      email: dadosUsuario['email'],
      dataNascimento: dadosUsuario['dataNascimento'].toDate(),
      fotoPerfil: dadosUsuario['fotoPerfil'],
    );
  }

  factory Usuario.initialUser() {
    return const Usuario(
      id: '',
      nome: '',
      email: '',
      dataNascimento: null,
      fotoPerfil: '',
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      nome,
      email,
      dataNascimento,
      fotoPerfil,
    ];
  }

  @override
  bool get stringify => true;
}
