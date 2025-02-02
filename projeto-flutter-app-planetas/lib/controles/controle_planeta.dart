import '../modelos/planeta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ControlePlaneta {
  static Database? _bd;

  //Método singleton que retorna uma referência para um banco de dados SQLite
  //Isso permite que o programa utulize sempre o mesmo banco de dados
  Future<Database> get bd async {
    if (_bd != null) return _bd!;
    _bd = await _initBD('planetas.db');
    return _bd!;
  }

  //Executa um script para a criação da tabela 'planetas'
  Future<void> _criarBD(Database bd, int versao) async {
    const sql = '''
    CREATE TABLE planetas (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      tamanho REAL NOT NULL,
      distancia REAL NOT NULL,
      apelido TEXT
    );
    ''';
    await bd.execute(sql);
  }

  //Inicializa o banco de dados e executa o método _criarBD
  //OBS: Ambos os meétodos são chamados apenas se não houver um banco de dados
  //associado ao método singleton
  Future<Database> _initBD(String localArquivo) async {
    final caminhoBD = await getDatabasesPath();
    final caminho = join(caminhoBD, localArquivo);
    return await openDatabase(
      caminho,
      version: 1,
      onCreate: _criarBD,
    );
  }

  //Retorna uma lista com as linhas da tabela 'planetas' convertidas para objetos do tipo Planeta
  Future<List<Planeta>> lerPlaneta() async {
    final db = await bd;
    final resultado = await db.query('planetas');
    return resultado.map((map) => Planeta.fromMap(map)).toList();
  }

  //Insere um planeta convertido para o formato Map na tabela 'planetas'
  Future<int> inserirPlaneta(Planeta planeta) async {
    final db = await bd;
    return await db.insert(
      'planetas',
      planeta.toMap(),
    );
  }

  //Deleta um planeta com base no id fornecido
  Future<int> excluirPlaneta(int id) async {
    final db = await bd;

    /*await db.execute('''
      DELETE FROM planetas
      WHERE id = $id;
    ''');*/

    return await db.delete(
      'planetas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //Altera os valores de uma linha na tabela 'planetas' com base no id do planeta fornecido
  Future<int> alterarPlaneta(Planeta planeta) async {
    final db = await bd;
    return db.update(
      'planetas',
      planeta.toMap(),
      where: 'id = ?',
      whereArgs: [planeta.id],
    );
  }
}
