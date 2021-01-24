class ResultadoUsuario {
  final String id;
  final String nome;
  final String email;
  final String endereco;
  final bool administrador;

  ResultadoUsuario({
    this.id,
    this.nome,
    this.email,
    this.endereco,
    this.administrador,
  });

  @override
  String toString() {
    return "User => $nome - Adm => $administrador ";
  }
}