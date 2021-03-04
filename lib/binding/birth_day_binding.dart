import 'package:foodcafe/controller/controller.dart';
import 'package:get/get.dart';

class BirthDayBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => BirthDayController());
}
