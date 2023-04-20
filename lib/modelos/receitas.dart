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
      nome: docReceita['nome'],
      ingredientes: docReceita['ingredientes'],
      etapas: docReceita['etapas'],
      tempoPreparo: docReceita['tempo_preparo'],
      peso: docReceita['peso'],
      calorias: docReceita['calorias'],
      urlImagem: docReceita['url_imagem'],
      idAutor: docReceita['id_autor'],
      categorias: docReceita['categorias'],
      vegetariana: docReceita['vegetariana'],
      vegana: docReceita['vegana'],
      semGluten: docReceita['sem_gluten'],
      semLactose: docReceita['sem_lactose'],
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
