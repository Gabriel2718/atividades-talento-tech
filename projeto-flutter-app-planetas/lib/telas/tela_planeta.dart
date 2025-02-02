import 'package:flutter/material.dart';
import '../modelos/planeta.dart';
import '../controles/controle_planeta.dart';

class TelaPlaneta extends StatefulWidget {
  final bool isIncluir;

  //Variável do tipo Function
  final Function() onFinalizado;

  final Planeta planeta;

  //A variável onFinalizado deve ser atribuída na contrução da classe
  const TelaPlaneta({
    super.key,
    required this.isIncluir,
    required this.planeta,
    required this.onFinalizado,
  });

  @override
  State<TelaPlaneta> createState() => _TelaPlaneta();
}

class _TelaPlaneta extends State<TelaPlaneta> {
  final _formKey = GlobalKey<FormState>();

  //Controladores dos campos de texto do formulário
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _tamanhoController = TextEditingController();
  final TextEditingController _distanciaController = TextEditingController();
  final TextEditingController _apelidoController = TextEditingController();

  final ControlePlaneta _controlePlaneta = ControlePlaneta();

  late Planeta _planeta;

  @override
  void dispose() {
    _nomeController.dispose();
    _tamanhoController.dispose();
    _distanciaController.dispose();
    _apelidoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _planeta = widget.planeta;
    _nomeController.text = _planeta.nome;
    _tamanhoController.text = _planeta.tamanho.toString();
    _distanciaController.text = _planeta.distancia.toString();
    //Se não houver apelido, será uma String vazia
    _apelidoController.text = _planeta.apelido ?? '';
    super.initState();
  }

  Future<void> _inserirPlaneta() async {
    await _controlePlaneta.inserirPlaneta(_planeta);
  }

  Future<void> _alterarPlaneta() async {
    await _controlePlaneta.alterarPlaneta(_planeta);
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      //Salvar formulário
      _formKey.currentState!.save();

      if (widget.isIncluir) {
        _inserirPlaneta();
      } else {
        _alterarPlaneta();
      }

      //Mensagem exibida ao enviar o formulário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Os dados do planeta ${_planeta.nome} foram ${widget.isIncluir ? 'incluídos' : 'alterados'} com sucesso!'),
        ),
      );
      Navigator.of(context).pop();
      //widget refere-se a um método do widget do qual esta classe herda o estado
      widget.onFinalizado();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cadastrar Planeta'),
        elevation: 3,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 3) {
                      return 'Por favor, insira o nome do planeta (Pelo menos 3 caracteres)';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _planeta.nome = value!;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _tamanhoController,
                  decoration: InputDecoration(
                    labelText: 'Tamanho (Km)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o tamanho do planeta';
                    } else if (double.tryParse(value) == null) {
                      return 'Insira um valor numérico válido';
                    } else if (double.tryParse(value)! <= 0.0) {
                      return 'Insira um valor positivo';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _planeta.tamanho = double.parse(value!);
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _distanciaController,
                  decoration: InputDecoration(
                    labelText: 'Distância do Sol (Unidades Astronômicas)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a distância do planeta em relação ao Sol';
                    } else if (double.tryParse(value) == null) {
                      return 'Insira um valor numérico válido';
                    } else if (double.tryParse(value)! <= 0.0) {
                      return 'Insira um valor positivo';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _planeta.distancia = double.parse(value!);
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _apelidoController,
                  decoration: InputDecoration(
                    labelText: 'Apelido',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) {
                    _planeta.apelido = value!;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submitForm(context);
                      },
                      child: Text('Salvar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
