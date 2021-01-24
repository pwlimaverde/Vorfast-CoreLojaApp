import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';

import '../../infra/datasources/checar_coneccao_datasource.dart';

class ConnectivityDatasource implements ChecarConeccaoDatasource {
  final Connectivity connectivity;

  ConnectivityDatasource({required this.connectivity});

  @override
  Future<bool> get isOnline async {
    var result = await connectivity.checkConnectivity();
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;
  }
}
