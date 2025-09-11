import 'package:connectivity_plus/connectivity_plus.dart';

extension ConnectivityExtension on Connectivity {
  Future<bool> get isInternet async => switch ((await checkConnectivity())[0]) {
    ConnectivityResult.bluetooth => false,
    ConnectivityResult.wifi => true,
    ConnectivityResult.ethernet => false,
    ConnectivityResult.mobile => true,
    ConnectivityResult.none => false,
    ConnectivityResult.vpn => false,
    ConnectivityResult.other => false,
  };
}
