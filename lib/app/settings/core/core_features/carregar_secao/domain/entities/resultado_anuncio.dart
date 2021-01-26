class ResultadoAnuncio {
  final String image;
  final int prioridade;
  final int produto;
  final int x;
  final int y;

  ResultadoAnuncio({
    this.image,
    this.prioridade,
    this.produto,
    this.x,
    this.y,
  });

  @override
  String toString() {
    return "Dados - $produto, $x, $y";
  }
}
