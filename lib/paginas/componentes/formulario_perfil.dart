import 'package:app_cronograma_receitas/blocs/perfil/perfil_cubit.dart';
import 'package:app_cronograma_receitas/modelos/modelos.dart';
import 'package:app_cronograma_receitas/paginas/componentes/botao_personalizado.dart';
import 'package:app_cronograma_receitas/paginas/componentes/campo_texto.dart';
import 'package:app_cronograma_receitas/utils/dialogo_erro.dart';
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
  late String? _imagem, _nome, _dataNascimento, _email, _telefone;
  late final TextEditingController _imagemController,
      _nomeController,
      _dataNascimentoController,
      _emailController,
      _telefoneController;

  @override
  void initState() {
    _imagemController =
        TextEditingController(text: widget.usuarioPadrao.fotoPerfil);
    _nomeController = TextEditingController(text: widget.usuarioPadrao.nome);
    _dataNascimentoController = TextEditingController(
        text: widget.usuarioPadrao.dataNascimento.toString());
    _emailController = TextEditingController(text: widget.usuarioPadrao.email);
    _telefoneController =
        TextEditingController(text: widget.usuarioPadrao.telefone);
    super.initState();
  }

  @override
  void dispose() {
    _imagemController.dispose();
    _nomeController.dispose();
    _dataNascimentoController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
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
        "imagem": _imagem,
        "nome": _nome,
        "data_nascimento": _dataNascimento,
        "email": _email,
        "telefone": _telefone,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PerfilCubit, PerfilState>(
      listener: (context, state) {
        if (state.statusPerfil == StatusPerfil.erro) {
          dialogoErro(context, state.erro);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: ListView(
            reverse: true,
            shrinkWrap: true,
            children: [
              //Campo de email
              CampoTexto(
                nomeCampo: 'Imagem',
                controller: _imagemController,
                icone: const Icon(Icons.image),
                onSaved: (String? value) {
                  _imagem = value!.trim();
                },
                tamanhoMinimo: 5,
              ),

              const SizedBox(height: 20.0),

              //Campo de email
              CampoTexto(
                nomeCampo: 'Nome',
                controller: _nomeController,
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
                controller: _dataNascimentoController,
                icone: const Icon(Icons.calendar_month),
                onSaved: (String? value) {
                  _dataNascimento = value!.trim();
                },
                tamanhoMinimo: 8,
                modoTeclado: TextInputType.datetime,
              ),

              const SizedBox(height: 20.0),

              //Campo de email
              CampoTexto(
                nomeCampo: 'Email',
                controller: _emailController,
                icone: const Icon(Icons.email),
                onSaved: (String? value) {
                  _email = value!.trim();
                },
                tamanhoMinimo: 10,
                ehEmail: true,
                modoTeclado: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20.0),

              //Campo de email
              CampoTexto(
                nomeCampo: 'Telefone',
                controller: _telefoneController,
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
                onPressed: _submit,
                corPrincipal: Colors.white,
                texto: state.statusPerfil == StatusPerfil.carregando
                    ? 'Carregando...'
                    : 'Salvar',
                corBorda: Colors.white,
                cortexto: Colors.black,
              ),
            ].reversed.toList(),
          ),
        );
      },
    );
  }
}
