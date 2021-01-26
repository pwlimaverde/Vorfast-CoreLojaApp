import 'package:connectivity/connectivity.dart';
import 'package:corelojaapp/app/settings/configuracao_geral/configuracao_geral_features/checar_coneccao/external/datasources_impl/connectivity_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ConnectivityMock extends Mock implements Connectivity {}

main() async {
  final connectivity = ConnectivityMock();
  final checarConeccao = ConnectivityDatasource(connectivity: connectivity);

  test('Deve Retornar um bool', () async {
    when(connectivity.checkConnectivity())
        .thenAnswer((_) => Future.value(ConnectivityResult.mobile));

    final result = await checarConeccao.isOnline;

    expect(result, isA<bool>());
  });
}
