class ResultadoSecao {
  final String nome;
  final String img;
  final int prioridade;
  final bool scrow;
  final Map cor;

  ResultadoSecao({
    this.nome,
    this.img,
    this.prioridade,
    this.scrow,
    this.cor,
  });

  @override
  String toString() {
    return "Dados - $nome, $cor";
  }
}
