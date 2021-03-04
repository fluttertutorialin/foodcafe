import 'dart:async';
import 'package:get/state_manager.dart';

class NotificationMinController extends GetxController {
  final message = Rx<String>("0".padLeft(2, '0'));
  Timer _timer;
  int i = 0;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  _init() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      i += 1;
      message.value = '$i'.padLeft(2, '0');
    });
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.onClose();
  }
}
