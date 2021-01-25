class ResultadoUsuario {
  final String id;
  final String nome;
  final String email;
  final String endereco;
  final bool administrador;

  ResultadoUsuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.endereco,
    required this.administrador,
  });

  @override
  String toString() {
    return "User => $nome - Adm => $administrador ";
  }
}
