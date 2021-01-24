class ResultadoTheme {
  final String user;
  final Map primary;
  final Map accent;

  ResultadoTheme({
    this.user,
    this.primary,
    this.accent,
  });

  @override
  String toString() {
    return "User => $user - Primary => $primary ";
  }
}
