import 'package:connectivity_plus/connectivity_plus.dart';

checksInternet<bool>() async {
  if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
    return false;
  } else {
    return true;
  }
}
