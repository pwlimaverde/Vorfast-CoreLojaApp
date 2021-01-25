class ResultadoAnuncio {
  final String image;
  final int prioridade;
  final int produto;
  final int x;
  final int y;

  ResultadoAnuncio({
    required this.image,
    required this.prioridade,
    required this.produto,
    required this.x,
    required this.y,
  });

  @override
  String toString() {
    return "Dados - $produto, $x, $y";
  }
}
