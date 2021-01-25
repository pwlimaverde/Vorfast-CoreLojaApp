class ResultadoTheme {
  final String user;
  final Map primary;
  final Map accent;

  ResultadoTheme({
    required this.user,
    required this.primary,
    required this.accent,
  });

  @override
  String toString() {
    return "User => $user - Primary => $primary ";
  }
}
