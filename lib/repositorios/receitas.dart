import 'package:app_cronograma_receitas/modelos/receitas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/constantes/constantes_db.dart';
import '/modelos/erro_personalizado.dart';

class RepositorioReceitas {
  final FirebaseFirestore firebaseFirestore;

  RepositorioReceitas({
    required this.firebaseFirestore,
  });

  Future<void> cadastraReceita({
    required String nome,
    required List<String> ingredientes,
    required String idAutor,
    required bool vegetariana,
    required bool vegana,
    required bool semGluten,
    required bool semLactose,
  }) async {
    try {
      await referenciaReceitas.doc().set({
        'nome': nome,
        'ingredientes': ingredientes,
        'id_autor': idAutor,
        'vegetariana': vegetariana,
        'vegana': vegana,
        'sem_gluten': semGluten,
        'sem_lactose': semLactose,
      });
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

  Future<Receita> buscaReceita({required String uid}) async {
    try {
      final DocumentSnapshot docReceita =
          await referenciaReceitas.doc(uid).get();

      if (docReceita.exists) {
        final receita = Receita.fromDoc(docReceita);
        return receita;
      }

      throw 'Receita não encontrada';
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
