import '../controller/controller.dart';
import 'package:get/get.dart';

class SupportBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => SupportController());
}
