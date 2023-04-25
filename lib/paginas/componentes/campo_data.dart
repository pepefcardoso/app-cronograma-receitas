// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:validators/validators.dart';

class CampoData extends StatelessWidget {
  const CampoData({
    Key? key,
    this.onSaved,
    this.validacao,
    this.valorInicial,
    this.autovalidateMode,
    this.habilitado = true,
    this.formatoData,
    this.estilo,
    required this.nome,
    required this.icone,
    this.modoSelecaoData = DateTimeFieldPickerMode.date,
  }) : super(key: key);

  final void Function(DateTime?)? onSaved;
  final String? Function(DateTime?)? validacao;
  final DateTime? valorInicial;
  final AutovalidateMode? autovalidateMode;
  final bool? habilitado;
  final DateFormat? formatoData;
  final InputDecoration? estilo;
  final String nome;
  final Icon icone;
  final DateTimeFieldPickerMode? modoSelecaoData;

  @override
  Widget build(BuildContext context) {
    return DateTimeFormField(
      use24hFormat: true,
      onSaved: onSaved,
      validator: validacao ?? validateField,
      initialValue: valorInicial,
      initialDate: valorInicial,
      autovalidateMode: autovalidateMode,
      enabled: habilitado!,
      dateFormat: formatoData ?? DateFormat('dd/MM/yyyy'),
      decoration: estilo ??
          InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
            hintText: nome,
            prefixIcon: icone,
          ),
      mode: modoSelecaoData!,
      onDateSelected: (DateTime value) {
        debugPrint(value.toString());
      },
    );
  }

  String? validateField(DateTime? value) {
    if (value == null) {
      return '$nome é obrigatório';
    } else if (!isDate(value.toString())) {
      return 'Insira uma data válida';
    }
    return null;
  }
}
