import 'package:get/get.dart';
import 'controller.dart';

class ProfileController extends GetxController {
  final _homeController = Get.put(HomeController());

  var userName = Rx<String>('');
  var emil = Rx<String>('');
  var address = Rx<String>('');

  @override
  onInit() {
    super.onInit();
    _homeController.getUserDetails();
    getUserDetails();
  }

  getUserDetails() {
    userName = _homeController.secureStorageUserNameRx;
    emil = _homeController.secureStorageEmailRx;
    address = _homeController.secureStorageAddressRx;
  }
}
