import 'dart:io';

import 'package:app_cronograma_receitas/constantes/constantes_db.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class SelecionaImagem extends StatefulWidget {
  const SelecionaImagem({
    required this.urlFotoPerfilController,
    required this.id,
    super.key,
  });

  final TextEditingController urlFotoPerfilController;
  final String id;

  @override
  State<SelecionaImagem> createState() => _SelecionaImagemState();
}

class _SelecionaImagemState extends State<SelecionaImagem> {
  void selecionaImagemGaleria() async {
    final imagemSelecionada = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    Reference ref =
        referenciaImagens.ref().child("perfil_cliente_${widget.id}.jpg");

    await ref.putFile(File(imagemSelecionada!.path));

    ref.getDownloadURL().then((value) async {
      setState(() {
        widget.urlFotoPerfilController.text = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 176,
          child: CircleAvatar(
            radius: 170,
            backgroundImage: NetworkImage(widget.urlFotoPerfilController.text),
          ),
        ),
        GestureDetector(
          onTap: selecionaImagemGaleria,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              height: 80,
              width: 80,
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.red,
                size: 70.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//https://github.com/Bytx-youtube/profilepicflutter/blob/main/profilescreen2.dart
//https://www.uplabs.com/posts/change-profile-picture-ui-5e4e9d0c-6f9b-49ac-8828-e52ed5d5aec0