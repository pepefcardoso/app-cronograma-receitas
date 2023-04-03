import 'package:app_cronograma_receitas/blocs/perfil/perfil_cubit.dart';
import 'package:app_cronograma_receitas/modelos/modelos.dart';
import 'package:app_cronograma_receitas/paginas/componentes/botao_personalizado.dart';
import 'package:app_cronograma_receitas/paginas/componentes/campo_texto.dart';
import 'package:app_cronograma_receitas/paginas/componentes/seleciona_imagem.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  late String? _nome, _dataNascimento, _telefone;
  late final TextEditingController _fotoPerfilController;

  @override
  void initState() {
    _fotoPerfilController = TextEditingController(
        text: context.read<PerfilCubit>().state.usuario.fotoPerfil);
  }

  @override
  void dispose() {
    _fotoPerfilController.dispose();
    super.dispose();
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
        // "foto_perfil": _fotoPerfil,
        "nome": _nome,
        "data_nascimento": _dataNascimento,
        "foto_perfil": _fotoPerfilController.text,
        "telefone": _telefone,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PerfilCubit, PerfilState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: ListView(
            shrinkWrap: true,
            children: [
              //Campo de email
              SelecionaImagem(
                  id: state.usuario.id,
                  urlFotoPerfilController: _fotoPerfilController),

              const SizedBox(height: 40.0),

              /*//Campo de email
              CampoTexto(
                nomeCampo: 'Foto de Perfil',
                valorInicial: state.usuario.fotoPerfil,
                icone: const Icon(Icons.image),
                onSaved: (String? value) {
                  _fotoPerfil = value!.trim();
                },
                tamanhoMinimo: 5,
              ),

              const SizedBox(height: 20.0),*/

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
                nomeCampo: 'Nascimento',
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
        );
      },
    );
  }
}
