import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FotoDePerfil extends StatefulWidget {
  const FotoDePerfil({
    super.key,
    required this.fotoPerfilUrl,
    required this.imagemPathController,
  });

  final String? fotoPerfilUrl;
  final TextEditingController imagemPathController;

  @override
  State<FotoDePerfil> createState() => _FotoDePerfilState();
}

class _FotoDePerfilState extends State<FotoDePerfil> {
  XFile? imagemDaGaleria;

  void selecionaImagemGaleria() async {
    final imagemSelecionada = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    if (imagemSelecionada != null) {
      setState(() {
        imagemDaGaleria = imagemSelecionada;
        widget.imagemPathController.text = imagemSelecionada.path;
      });
    }
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
            backgroundColor: Colors.white,
            backgroundImage: imagemDaGaleria != null
                ? FileImage(File(imagemDaGaleria!.path)) as ImageProvider
                : NetworkImage(widget.fotoPerfilUrl ??
                    "https://cdn-icons-png.flaticon.com/512/118/118174.png?w=826&t=st=1682012779~exp=1682013379~hmac=675bd67fb8221ed496e42139bfae3483ec568c2701db4ad676b60aca8c94bf4f"),
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
