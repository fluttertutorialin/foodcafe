import 'package:foodcafe/controller/controller.dart';
import 'package:get/get.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => ChangePasswordController());
}
