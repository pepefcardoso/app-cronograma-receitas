import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CampoDataRegistro extends StatelessWidget {
  const CampoDataRegistro({
    required this.nomeCampo,
    required this.icone,
    this.onSaved,
    this.controller,
    this.dataInicial,
    this.dataFinal,
    this.dataPadrao,
    super.key,
  });

  final Icon icone;
  final String nomeCampo;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final DateTime? dataInicial;
  final DateTime? dataFinal;
  final DateTime? dataPadrao;

  @override
  Widget build(BuildContext context) {
    MaskTextInputFormatter mascaraDataNascimento = MaskTextInputFormatter(
      mask: "##/##/####",
      filter: {"#": RegExp("[0-9]")},
      type: MaskAutoCompletionType.lazy,
    );

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      autocorrect: false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: nomeCampo,
        prefixIcon: icone,
      ),
      validator: validateField,
      onSaved: onSaved,
      inputFormatters: [mascaraDataNascimento],
    );
  }

  String? validateField(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return '$nomeCampo é obrigatório';
    }

    try {
      DateFormat('dd/MM/yyyy').parse(value!.trim());
    } catch (e) {
      return '$nomeCampo inválido!';
    }

    return null;
  }
}
