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
      obscureText: ehSenha,
      keyboardType: modoTeclado,
      autocorrect: false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: nomeCampo,
        prefixIcon: icone,
      ),
      validator: (String? value) {
        if (confirmacaoSenha != null && confirmacaoSenha != value) {
          return 'As senhas não são iguais';
        }

        if (value == null || value.trim().isEmpty) {
          return '$nomeCampo é obrigatório';
        }

        if (value.trim().length < tamanhoMinimo) {
          return '$nomeCampo precisa ter pelo menos $tamanhoMinimo caracteres';
        }

        if (ehEmail) {
          if (!isEmail(value.trim())) {
            return 'Insira um email válido';
          }
        }

        return null;
      },
      onSaved: onSaved,
    );
  }
}
