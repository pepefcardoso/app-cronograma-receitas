// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Receita extends Equatable {
  final String id;
  final String nome;
  final List<String> ingredientes;
  final List<String>? etapas;
  final int? tempoPreparo;
  final int? peso;
  final int? calorias;
  final String? urlImagem;
  final String idAutor;
  final List<String>? categorias;
  final bool vegetariana;
  final bool vegana;
  final bool semGluten;
  final bool semLactose;

  const Receita({
    required this.id,
    required this.nome,
    required this.ingredientes,
    this.etapas,
    this.tempoPreparo,
    this.peso,
    this.calorias,
    this.urlImagem,
    required this.idAutor,
    this.categorias,
    required this.vegetariana,
    required this.vegana,
    required this.semGluten,
    required this.semLactose,
  });

  factory Receita.fromDoc(DocumentSnapshot docReceita) {
    final dadosreceita = docReceita.data() as Map<String, dynamic>?;

    return Receita(
      id: docReceita.id,
      nome: dadosreceita!['nome'],
      ingredientes: dadosreceita['ingredientes'],
      etapas: dadosreceita['etapas'],
      tempoPreparo: dadosreceita['tempo_preparo'],
      peso: dadosreceita['peso'],
      calorias: dadosreceita['calorias'],
      urlImagem: dadosreceita['url_imagem'],
      idAutor: dadosreceita['id_autor'],
      categorias: dadosreceita['categorias'],
      vegetariana: dadosreceita['vegetariana'],
      vegana: dadosreceita['vegana'],
      semGluten: dadosreceita['sem_gluten'],
      semLactose: dadosreceita['sem_lactose'],
    );
  }

  factory Receita.initialUser() {
    return const Receita(
      id: '',
      nome: '',
      ingredientes: [],
      etapas: null,
      tempoPreparo: null,
      peso: null,
      calorias: null,
      urlImagem: null,
      idAutor: '',
      categorias: null,
      vegetariana: false,
      vegana: false,
      semGluten: false,
      semLactose: false,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      nome,
      ingredientes,
      etapas,
      tempoPreparo,
      peso,
      calorias,
      urlImagem,
      idAutor,
      categorias,
      vegetariana,
      vegana,
      semGluten,
      semLactose,
    ];
  }

  @override
  bool get stringify => true;
}
