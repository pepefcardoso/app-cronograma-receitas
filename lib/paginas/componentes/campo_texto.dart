import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class CampoTexto extends StatelessWidget {
  const CampoTexto({
    required this.nomeCampo,
    required this.icone,
    this.onSaved,
    this.confirmacaoSenha,
    this.modoTeclado,
    this.tamanhoMinimo = 5,
    this.ehEmail = false,
    this.ehSenha = false,
    this.controller,
    this.valorInicial,
    this.habilitado = true,
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
  final dynamic valorInicial;
  final bool habilitado;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: habilitado,
      controller: controller,
      initialValue: valorInicial,
      obscureText: ehSenha,
      keyboardType: modoTeclado,
      autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        filled: true,
        fillColor: Colors.grey.shade200,
        hintText: nomeCampo,
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
        debugPrint(confirmacaoSenha);
        debugPrint(value);
        return 'As senhas não conferem';
      }

      return null;
    }
  }
}
