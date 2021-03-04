import 'package:foodcafe/controller/controller.dart';
import 'package:get/get.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => NotificationController());
}
