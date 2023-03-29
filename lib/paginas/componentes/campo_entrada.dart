import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class CampoEntrada extends StatelessWidget {
  const CampoEntrada({
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
