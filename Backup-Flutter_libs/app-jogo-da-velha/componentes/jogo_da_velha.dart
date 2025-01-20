import 'dart:math';

import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  const Jogo({super.key});

  @override
  State<Jogo> createState() => _Jogo();
}

class _Jogo extends State<Jogo> {
  List<String> _tabuleiro = List.filled(9, '');
  String _jogador = 'X';
  bool _contraMaquina = false;
  final Random _randomico = Random();
  bool _pensando = false;

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height * 0.5;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 0.6,
              child: Switch(
                  value: _contraMaquina,
                  onChanged: (value) {
                    setState(() {
                      _contraMaquina = value;
                      _iniciarJogo();
                    });
                  }),
            ),
            Text(_contraMaquina ? 'Computador' : 'Humano'),
            const SizedBox(
              width: 30.0,
            ),
            if (_pensando)
              const SizedBox(
                width: 15.0,
                height: 15.0,
                child: CircularProgressIndicator(),
              ),
          ],
        ),
        SizedBox(
          width: altura,
          height: altura,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            itemCount: 9,
            itemBuilder: (constext, index) {
              return GestureDetector(
                  onTap: () => _jogada(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        _tabuleiro[index],
                        style: const TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ));
            },
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
          onPressed: _iniciarJogo,
          child: const Text('Reiniciar Jogo'),
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  void _jogada(int index) {
    if (_tabuleiro[index] == '') {
      setState(() {
        _tabuleiro[index] = _jogador;
        if (!_verificaVencedor(_jogador)) {
          _trocaJogador();
          if (_contraMaquina && _jogador == 'O') {
            _jogadaComputador();
          }
        }
      });
    }
  }

  bool _verificaVencedor(String jogador) {
    const posicoesVencedoras = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var posicoes in posicoesVencedoras) {
      if (_tabuleiro[posicoes[0]] == jogador &&
          _tabuleiro[posicoes[1]] == jogador &&
          _tabuleiro[posicoes[2]] == jogador) {
        _mostraDialogoVencedor(_jogador);
        return true;
      }
    }
    if (!_tabuleiro.contains('')) {
      _mostraDialogoVencedor('Empate');
      return true;
    }
    return false;
  }

  void _trocaJogador() {
    setState(() {
      _jogador = _jogador == 'X' ? 'O' : 'X';
    });
  }

  void _mostraDialogoVencedor(String vencedor) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text(vencedor == 'Empate' ? 'Empate!' : 'Vencedor: $vencedor'),
            actions: [
              ElevatedButton(
                child: const Text('Reiniciar jogo'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _iniciarJogo();
                },
              ),
            ],
          );
        });
  }

  void _jogadaComputador() {
    setState(() => _pensando = true);
    Future.delayed(const Duration(seconds: 1), () {
      int movimento;
      do {
        movimento = _randomico.nextInt(9);
      } while (_tabuleiro[movimento] != '');
      setState(() {
        _tabuleiro[movimento] = 'O';
        if (!_verificaVencedor(_jogador)) {
          _trocaJogador();
        }
        _pensando = false;
      });
    });
  }

  void _iniciarJogo() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        _tabuleiro[i] = '';
      }
      _jogador = 'X';
    });
  }
}
