import 'package:flutter/material.dart';
import 'package:flutter_application_1/telas/tela_informacoes.dart';
import 'telas/tela_planeta.dart';
import 'modelos/planeta.dart';
import 'controles/controle_planeta.dart';

void main() {
  runApp(const MyApp());
}

//A classe MyApp foi alterada para StatefulWidget, para possibilitar a troca de temas (escuro/claro)
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  bool _modoEscuroAtivado = false; // Estado do tema (padrão: claro)

  void _alterarTema(bool value) {
    setState(() {
      _modoEscuroAtivado = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Planetas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: _modoEscuroAtivado ? Brightness.dark : Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'App - Planetas',
        temaEscuro: _modoEscuroAtivado,
        onAlternarTema: _alterarTema,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final bool temaEscuro;
  final ValueChanged<bool> onAlternarTema;

  //Além do título, a classe MyHomePage deve especificar em su construtor um valor booleano (estado do tema)
  //e um método (neste caso o método que altera a variável _temaEscuroAtivado)
  const MyHomePage({
    super.key,
    required this.title,
    required this.temaEscuro,
    required this.onAlternarTema,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ControlePlaneta _controlePlaneta =
      ControlePlaneta(); //Classe que realiza as operações no banco de dados SQLite

  List<Planeta> _planetas = []; //Lista de planetas

  @override
  void initState() {
    super.initState();
    _carregarTela();
  }

  //Altera os valores da lista '_planetas' com base nos resultados da consulta no banco de dados
  Future<void> _lerPlanetas() async {
    final resultado = await _controlePlaneta.lerPlaneta();
    setState(() {
      _planetas = resultado;
    });
  }

  Future<void> _carregarTela() async {
    await _lerPlanetas();
  }

  //Inicializa a tela de cadastro com os valores nos campos do formulário vazios
  void _incluirPlaneta(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaPlaneta(
          isIncluir: true,
          planeta: Planeta.vazio(),
          onFinalizado: () {
            _lerPlanetas();
          },
        ),
      ),
    );
  }

  //Inicializa a tela de cadastro com os valores dos atributos do planeta que será
  //alterado no campos do formulário
  Future<void> _alterarPlaneta(BuildContext context, Planeta planeta) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaPlaneta(
          isIncluir: false,
          planeta: planeta,
          onFinalizado: () {
            _lerPlanetas();
          },
        ),
      ),
    );
  }

  //Inicializa a tela de informações detalhadas
  void _exibirInfo(Planeta planeta) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaInformacoes(planeta: planeta),
      ),
    );
  }

  //Abre um pop-up para que o usuário confirme ou cancele a exclusão de um planeta
  void _confirmarExclusao(String nome, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Exclusão'),
          content: Text('Tem certeza que deseja excluir $nome?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Não'),
            ),
            TextButton(
              onPressed: () {
                _excluirPlaneta(id);
                Navigator.of(context).pop();
              },
              child: Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _excluirPlaneta(int id) async {
    await _controlePlaneta.excluirPlaneta(id);
    _lerPlanetas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          Row(
            children: [
              //Funcionalidade de troca de temas (claro/escuro)
              Icon(widget.temaEscuro ? Icons.nightlight : Icons.wb_sunny),
              Switch(
                value: widget.temaEscuro,
                onChanged: widget.onAlternarTema,
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        //Lista contruída na tela inicial cujo tamanho está associado ao tamanho da lista de planetas.
        //A cada atualização, os valores contidos na lista '_planetas' são automaticamente inseridos ou removidos da tela inicial
        itemCount: _planetas.length,
        itemBuilder: (context, index) {
          final planeta = _planetas[index];
          return ListTile(
            title: Text(planeta.nome),
            subtitle: Text(planeta.apelido!),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    _exibirInfo(planeta);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _alterarPlaneta(context, planeta);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _confirmarExclusao(planeta.nome, planeta.id!);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incluirPlaneta(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
