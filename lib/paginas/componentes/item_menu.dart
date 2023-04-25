import 'package:flutter/material.dart';

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    this.nome = "",
    this.imagem = 'assets/images/refeicao_amigos.jpg',
    super.key,
  });

  final String? nome;
  final String? imagem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  child: Image.asset(
                    imagem!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    width: 240,
                    color: Colors.black87,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 6,
                    ),
                    child: Text(
                      nome!,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
