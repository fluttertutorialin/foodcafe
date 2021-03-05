import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:foodcafe/resource/colors.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:get/get.dart';
import 'package:foodcafe/utils/extensions.dart';

class NetworkController extends GetxController {
  static NetworkController get to => Get.find();
  var _connectivity = Connectivity();

  Future<int> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e);
    }
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
