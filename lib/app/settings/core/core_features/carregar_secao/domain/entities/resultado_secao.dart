class ResultadoSecao {
  final String nome;
  final String img;
  final int prioridade;
  final bool scrow;
  final Map cor;

  ResultadoSecao({
    required this.nome,
    required this.img,
    required this.prioridade,
    required this.scrow,
    required this.cor,
  });

  @override
  String toString() {
    return "Dados - $nome, $cor";
  }
}
