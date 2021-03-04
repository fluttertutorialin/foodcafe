import 'package:foodcafe/controller/controller.dart';
import 'package:get/get.dart';

class ProfileEditBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => ProfileEditController());
}
