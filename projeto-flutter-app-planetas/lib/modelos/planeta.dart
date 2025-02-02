class Planeta {
  int? id;
  String nome;
  double tamanho; //Circunferência
  double distancia; //Em relação ao Sol
  String? apelido; //Ex: Terra - planeta azul

  //Construtor padrão
  Planeta({
    this.id,
    required this.nome,
    required this.tamanho,
    required this.distancia,
    this.apelido,
  });

  //Contrutor alternativo
  Planeta.vazio()
      : nome = '',
        tamanho = 0.0,
        distancia = 0.0,
        apelido = '';

  //Função estática, converte um Map (registro de chave e valor) em um objeto do tipo Planeta
  factory Planeta.fromMap(Map<String, dynamic> mapa) {
    return Planeta(
      id: mapa['id'],
      nome: mapa['nome'],
      tamanho: mapa['tamanho'],
      distancia: mapa['distancia'],
      apelido: mapa['apelido'],
    );
  }

  //Converte um objeto do tipo planeta em um Map (registro de chave e valor)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'tamanho': tamanho,
      'distancia': distancia,
      'apelido': apelido,
    };
  }
}
