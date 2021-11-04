import '../controller/controller.dart';
import 'package:get/get.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => SingUpController(
      fireStoreDatabaseRepository: Get.find(), sessionStore: Get.find()));
}
