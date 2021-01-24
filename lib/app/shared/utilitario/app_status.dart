enum AppStatus { loading, success, error, none }

extension AppStatusExt on AppStatus {
  static var _valor;
  get valorGet => _valor;
  set valorSet(valor) => _valor = valor;
}
