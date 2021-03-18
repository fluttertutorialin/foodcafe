import '../controller/controller.dart';
import 'package:get/get.dart';

class PastOrderDetailBinging extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => PastOrderDetailController());
}
