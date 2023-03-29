import 'package:flutter/material.dart';

class MarcaDoApp extends StatelessWidget {
  const MarcaDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          "assets/images/panela_1.png",
          height: 60,
          width: 60,
        ),
        const SizedBox(width: 20.0),
        const Text(
          "Receitaria",
          style: TextStyle(
            color: Colors.white,
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
