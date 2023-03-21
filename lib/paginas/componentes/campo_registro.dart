import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class CampoRegistro extends StatelessWidget {
  const CampoRegistro({
    required this.nomeCampo,
    required this.icone,
    this.onSaved,
    this.confirmacaoSenha,
    this.modoTeclado,
    required this.tamanhoMinimo,
    this.ehEmail = false,
    this.ehSenha = false,
    this.controller,
    super.key,
  });

  final bool ehEmail;
  final bool ehSenha;
  final Icon icone;
  final TextInputType? modoTeclado;
  final String nomeCampo;
  final void Function(String?)? onSaved;
  final String? confirmacaoSenha;
  final int tamanhoMinimo;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: ehSenha,
      keyboardType: modoTeclado,
      autocorrect: false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: nomeCampo,
        prefixIcon: icone,
      ),
      validator: validateField,
      onSaved: onSaved,
    );
  }

  String? validateField(String? value) {
    if (confirmacaoSenha == null) {
      if (value?.trim().isEmpty ?? true) {
        return '$nomeCampo é obrigatório';
      }

      if (value!.trim().length < tamanhoMinimo) {
        return '$nomeCampo precisa ter pelo menos $tamanhoMinimo caracteres';
      }

      if (ehEmail && !isEmail(value.trim())) {
        return 'Insira um email válido';
      }

      return null;
    } else {
      if (confirmacaoSenha != value) {
        print(confirmacaoSenha);
        print(value);
        return 'As senhas não conferem';
      }

      return null;
    }
  }
}
