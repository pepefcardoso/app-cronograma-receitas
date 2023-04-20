import 'dart:io';

import 'package:app_cronograma_receitas/blocs/perfil/perfil_cubit.dart';
import 'package:app_cronograma_receitas/constantes/constantes_db.dart';
import 'package:app_cronograma_receitas/modelos/modelos.dart';
import 'package:app_cronograma_receitas/paginas/componentes/botao_personalizado.dart';
import 'package:app_cronograma_receitas/paginas/componentes/campo_texto.dart';
import 'package:app_cronograma_receitas/paginas/componentes/foto_de_perfil.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormularioPerfil extends StatefulWidget {
  const FormularioPerfil({
    super.key,
    required this.usuarioPadrao,
  });

  final Usuario usuarioPadrao;

  @override
  State<FormularioPerfil> createState() => FormularioPerfilState();
}

class FormularioPerfilState extends State<FormularioPerfil> {
  late TextEditingController fotoPerfilController;

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String? _nome, _dataNascimento, _telefone;

  @override
  void dispose() {
    fotoPerfilController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    fotoPerfilController = TextEditingController();
    super.initState();
  }

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    final String uid = context.read<PerfilCubit>().state.usuario.id;

    context.read<PerfilCubit>().atualizaPerfil(
        uid: uid,
        info: {
          "nome": _nome,
          "data_nascimento": _dataNascimento,
          "telefone": _telefone,
        },
        fotoPerfil: fotoPerfilController.text == ""
            ? null
            : File(fotoPerfilController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PerfilCubit, PerfilState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: ListView(
              shrinkWrap: true,
              children: [
                //Campo de email
                Align(
                  alignment: Alignment.center,
                  child: FotoDePerfil(
                    fotoPerfilUrl: state.usuario.fotoPerfil,
                    imagemPathController: fotoPerfilController,
                  ),
                ),

                const SizedBox(height: 30.0),

                //Campo de email
                CampoTexto(
                  nomeCampo: 'Nome',
                  valorInicial: state.usuario.nome,
                  icone: const Icon(Icons.person),
                  onSaved: (String? value) {
                    _nome = value!.trim();
                  },
                  tamanhoMinimo: 5,
                ),

                const SizedBox(height: 20.0),

                //Campo de email
                CampoTexto(
                  nomeCampo: 'Data de Nascimento',
                  valorInicial: state.usuario.dataNascimento,
                  icone: const Icon(Icons.calendar_month),
                  onSaved: (String? value) {
                    _dataNascimento = value!.trim();
                  },
                  tamanhoMinimo: 8,
                  modoTeclado: TextInputType.datetime,
                ),

                const SizedBox(height: 20.0),

                //Campo de email
                Tooltip(
                  message: "Não é possível alterar o email",
                  triggerMode: TooltipTriggerMode.tap,
                  child: CampoTexto(
                    nomeCampo: 'Email',
                    habilitado: false,
                    valorInicial: state.usuario.email,
                    icone: const Icon(Icons.email),
                  ),
                ),

                const SizedBox(height: 20.0),

                //Campo de email
                CampoTexto(
                  nomeCampo: 'Telefone',
                  valorInicial: state.usuario.telefone,
                  icone: const Icon(Icons.phone),
                  onSaved: (String? value) {
                    _telefone = value!.trim();
                  },
                  tamanhoMinimo: 11,
                  modoTeclado: TextInputType.phone,
                ),

                const SizedBox(height: 20.0),

                //Botão de submit
                BotaoPersonalizado(
                  onPressed: state.statusPerfil == StatusPerfil.atualizando
                      ? () {}
                      : _submit,
                  corPrincipal: Colors.white,
                  texto: state.statusPerfil == StatusPerfil.atualizando
                      ? 'Carregando...'
                      : 'Salvar',
                  corBorda: Colors.white,
                  cortexto: Colors.black,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
