import 'package:flutter/material.dart';

class SelecionaImagem extends StatefulWidget {
  const SelecionaImagem({super.key});

  @override
  State<SelecionaImagem> createState() => _SelecionaImagemState();
}

class _SelecionaImagemState extends State<SelecionaImagem> {
  @override
  Widget build(BuildContext context) {
    return const InkWell(
      child: CircleAvatar(
        radius: 140.0,
        child: Icon(
          Icons.person,
          size: 180.0,
        ),
      ),
    );
  }
}

//https://github.com/Bytx-youtube/profilepicflutter/blob/main/profilescreen2.dart
//https://monik.hashnode.dev/how-to-create-a-hover-effect-in-flutter-in-minutes