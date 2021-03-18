import '../controller/controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => LoginController(
      localAuthRepository: Get.find(),
      fireStoreDatabaseRepository: Get.find()));
}
