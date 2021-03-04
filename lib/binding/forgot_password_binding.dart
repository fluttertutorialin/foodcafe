import 'package:foodcafe/controller/controller.dart';
import 'package:get/get.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => ForgotPasswordController());
}
