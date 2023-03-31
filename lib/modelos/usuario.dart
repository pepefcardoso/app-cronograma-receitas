import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  final String id;
  final String? nome;
  final String email;
  final String? dataNascimento; //TODO DATETIME
  final String? fotoPerfil;
  final String? telefone;

  const Usuario({
    required this.id,
    this.nome,
    required this.email,
    this.dataNascimento,
    this.fotoPerfil,
    this.telefone,
  });

  factory Usuario.fromDoc(DocumentSnapshot docUsuario) {
    final dadosUsuario = docUsuario.data() as Map<String, dynamic>?;

    return Usuario(
      id: docUsuario.id,
      nome: dadosUsuario!['nome'],
      email: dadosUsuario['email'],
      dataNascimento: dadosUsuario['data_nascimento'],
      fotoPerfil: dadosUsuario['foto_perfil'],
      telefone: dadosUsuario['telefone'],
    );
  }

  factory Usuario.initialUser() {
    return const Usuario(
      id: '',
      nome: null,
      email: '',
      dataNascimento: null,
      fotoPerfil: null,
      telefone: null,
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
      telefone,
    ];
  }

  @override
  bool get stringify => true;
}
