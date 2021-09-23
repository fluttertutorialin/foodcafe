import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import '../resource/colors.dart';
import '../resource/value.dart';
import '../utils/extensions.dart';

class NetworkController extends GetxController {
  static NetworkController get to => Get.find();
  final _connectivity = Connectivity();

  Future<int> initConnectivity() async {
    ConnectivityResult result;
    result = await _connectivity.checkConnectivity();

    return _updateConnectionStatus(result);
  }

  _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return netWorkConnectionWIFI;
        break;
      case ConnectivityResult.mobile:
        return netWorkConnectionMobile;
        break;
      case ConnectivityResult.none:
        toast(
            title: networkErrorTitleMessage,
            message: networkErrorMessage,
            textColor: toastMessageOrderColor,
            backgroundColor: toastBackgroundOrderColor,
            flushBarPosition: toastPositionBottom);
        return netWorkConnectionError;
        break;
    }
  }
}
