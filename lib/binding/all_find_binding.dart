import 'package:foodcafe/controller/controller.dart';
import 'package:get/get.dart';

class AllFindBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => AllFindController());
}
