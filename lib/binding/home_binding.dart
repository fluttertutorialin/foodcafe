import 'package:foodcafe/controller/controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => PendingController());
    Get.lazyPut(() => AcceptedController());
    Get.lazyPut(() => ReadyController());
    Get.lazyPut(() => DispatchedController());

    Get.lazyPut(() => NotificationFirebaseController());

    Get.lazyPut(() => DeliveryTypesController());
    Get.lazyPut(() => PauseMenuController());
    Get.lazyPut(() => PastOrderController());
    Get.lazyPut(() => KDSViewController());
  }
}
