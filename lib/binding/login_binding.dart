import '../shared/provider/session_store.dart';
import '../controller/controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => LoginController(
      sessionStore: SessionStoreImp(Get.find()),
      fireStoreDatabaseRepository: Get.find()));
}
