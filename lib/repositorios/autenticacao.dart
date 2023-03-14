import 'package:cloud_firestore/cloud_firestore.dart';
import '/constantes/constantes_db.dart';
import '/modelos/erro_personalizado.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

class RepositorioAutenticacao {
  final FirebaseFirestore firebaseFirestore;
  final fb_auth.FirebaseAuth firebaseAuth;
  RepositorioAutenticacao({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  Stream<fb_auth.User?> get user => firebaseAuth.userChanges();

  Future<void> signup({
    required String nome,
    required String email,
    required String senha,
    required DateTime dataNascimento,
  }) async {
    try {
      final fb_auth.UserCredential credencialUsuario =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      final signedInUser = credencialUsuario.user!;

      await referenciaUsuarios.doc(signedInUser.uid).set({
        'name': nome,
        'email': email,
        'dataNascimento': dataNascimento,
      });
    } on fb_auth.FirebaseAuthException catch (e) {
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

  Future<void> signin({
    required String email,
    required String senha,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
    } on fb_auth.FirebaseAuthException catch (e) {
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

  Future<void> signout() async {
    await firebaseAuth.signOut();
  }
}
