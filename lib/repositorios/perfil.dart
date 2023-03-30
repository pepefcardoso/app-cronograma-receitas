import 'package:cloud_firestore/cloud_firestore.dart';
import '/constantes/constantes_db.dart';
import '/modelos/erro_personalizado.dart';
import '/modelos/usuario.dart';

class RepositorioPerfil {
  final FirebaseFirestore firebaseFirestore;

  RepositorioPerfil({
    required this.firebaseFirestore,
  });

  Future<Usuario> buscaPerfil({required String uid}) async {
    try {
      final DocumentSnapshot docUsuario =
          await referenciaUsuarios.doc(uid).get();

      if (docUsuario.exists) {
        final usuarioAtual = Usuario.fromDoc(docUsuario);
        return usuarioAtual;
      }

      throw 'Usuário não encontrado';
    } on FirebaseException catch (e) {
      throw ErroPersonalizado(
        codigo: e.code,
        mensagem: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw ErroPersonalizado(
        codigo: 'Exception',
        mensagem: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<Usuario> atualizaPerfil({
    required String uid,
    required Map<String, dynamic> info,
  }) async {
    try {
      await referenciaUsuarios.doc(uid).update(info);

      Usuario usuarioAtualizado = await buscaPerfil(uid: uid);

      return usuarioAtualizado;
    } on FirebaseException catch (e) {
      throw ErroPersonalizado(
        codigo: e.code,
        mensagem: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw ErroPersonalizado(
        codigo: 'Exception',
        mensagem: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }
}
