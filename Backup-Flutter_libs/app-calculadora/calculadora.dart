import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() {
    return _Calc();
  }
}

class _Calc extends State<Calculadora> {
  final String _limpar = 'Limpar';
  String _expressao = '';
  String _resultado = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Text(
            _expressao,
            style: const TextStyle(fontSize: 30),
          ),
        ),
        Expanded(
          child: Text(
            _resultado,
            style: const TextStyle(fontSize: 30),
          ),
        ),
        Expanded(
          flex: 3,
          child:
              GridView.count(crossAxisCount: 4, childAspectRatio: 2, children: [
            _botao('7'),
            _botao('8'),
            _botao('9'),
            _botao('÷'),
            _botao('4'),
            _botao('5'),
            _botao('6'),
            _botao('x'),
            _botao('1'),
            _botao('2'),
            _botao('3'),
            _botao('-'),
            _botao('0'),
            _botao('.'),
            _botao('='),
            _botao('+'),
            _botao('('),
            _botao(')'),
          ]),
        ),
        Expanded(
          child: _botao(_limpar),
        ),
      ],
    );
  }

  Widget _botao(String valor) {
    return TextButton(
      child: Text(
        valor,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        _presionarBotao(valor);
      },
    );
  }

  void _presionarBotao(String valor) {
    setState(() {
      if (valor == _limpar) {
        _expressao = '';
        _resultado = '';
      } else if (valor == '=') {
        _calcularResultado();
      } else {
        _expressao += valor;
      }
    });
  }

  void _calcularResultado() {
    setState(() {
      try {
        _resultado = _expressao.split('=').last;
        _resultado = _avaliarExpressao(_expressao).toString();
      } catch (e) {
        _resultado = 'Erro: não foi possível calcular';
      }
    });
  }

  double _avaliarExpressao(String expressao) {
    expressao = expressao.replaceAll('x', '*');
    expressao = expressao.replaceAll('÷', '/');
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    double resultado = avaliador.eval(Expression.parse(expressao), {});
    return resultado;
  }
}
