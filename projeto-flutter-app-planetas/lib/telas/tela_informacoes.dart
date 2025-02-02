import 'package:flutter/material.dart';
import '../modelos/planeta.dart';

class TelaInformacoes extends StatefulWidget {
  final Planeta planeta;

  const TelaInformacoes({
    super.key,
    required this.planeta,
  });

  @override
  State<TelaInformacoes> createState() => _TelaInformacoes();
}

class _TelaInformacoes extends State<TelaInformacoes> {
  @override
  void initState() {
    super.initState();
  }

  //Layout com as informações detalhadas do planeta passado como parâmetro na iniciaçização
  @override
  Widget build(BuildContext context) {
    final planeta = widget.planeta;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(planeta.nome),
        elevation: 3,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tamanho',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${planeta.tamanho} km',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Distância do Sol',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${planeta.distancia} UA',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            //Caso o planeta não possuia um apelido, este item não será inserido
            if (planeta.apelido != null && planeta.apelido!.isNotEmpty) ...[
              Text(
                'Apelido',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                planeta.apelido!,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
