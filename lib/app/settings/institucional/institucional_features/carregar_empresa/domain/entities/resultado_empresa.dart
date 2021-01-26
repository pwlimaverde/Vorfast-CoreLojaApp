class ResultadoEmpresa {
  final String nome;
  final String logo260x200;
  final bool licenca;

  ResultadoEmpresa({
    this.nome,
    this.logo260x200,
    this.licenca,
  });

  @override
  String toString() {
    return "Empresa => $nome - Ativa => $licenca ";
  }
}
