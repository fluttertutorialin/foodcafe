import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/controller.dart';
import '../utils/extensions.dart';
import '../utils/state_status.dart';

class ProfileEditController extends GetxController {
  static ProfileEditController get to => Get.find();
  final _homeController = Get.put(HomeController());
  var stateStatus = Rx<StateStatus>(StateStatus.initial);

  var userNameController = TextEditingController();
  var mobileController = TextEditingController();
  var pinCodeController = TextEditingController();
  var addressController = TextEditingController();

  String _userName = '', _mobile = '', _pinCode = '', _address = '';

  var autoValidate = Rx<bool>(false);
  var profileURL = Rx<String>('');
  var userName = Rx<String>('');

  var imagePickerPath = Rx<String>('');

  changeUserName(String value) {
    _userName = value;
  }

  changeMobile(String value) {
    _mobile = value;
  }

  changePinCode(String value) {
    _pinCode = value;
  }

  changeAddress(String value) {
    _address = value;
  }

  checkAutoValidate() {
    autoValidate.value = true;
  }

  @override
  onInit() {
    super.onInit();
    _homeController.getUserDetails();

    userNameController.text = _homeController.secureStorageUserNameRx.value;
    mobileController.text = _homeController.secureStorageMobileRx.value;
    pinCodeController.text = _homeController.secureStoragePinCodeRx.value;
    addressController.text = _homeController.secureStorageAddressRx.value;

    profileURL.value = _homeController.secureStorageProfileUrlRx.value;
    userName.value = _homeController.secureStorageUserNameRx.value;
  }

  setImagePickerPath(String path) {
    imagePickerPath.value = path;
  }

  Future<void> callProfile() async {
    stateStatus.value = StateStatus.loading;

    _homeController.setUserDetails(
      userName: _userName == '' ? _homeController.secureStorageUserNameRx.value : _userName,
      mobile:
      _mobile == '' ? _homeController.secureStorageMobileRx.value : _mobile,
      pinCode: _pinCode == '' ? _homeController.secureStoragePinCodeRx.value : _pinCode,
      address: _address == '' ? _homeController.secureStorageAddressRx.value : _address,
    );
    _homeController.getUserDetails();

    stateStatus.value = StateStatus.success;

    _clearTextField();
    Get.back();
  }

  _clearTextField() {
    userNameController.clear();
    mobileController.clear();
    pinCodeController.clear();
    addressController.clear();
  }

  String isUserNameValid(String value) => value.validUserName();

  String isEmailValid(String value) => value.validateEmail();

  String isMobileValid(String value) => value.validateMobile();

  String isPinCodeValid(String value) => value.validatePinCode();

  String isAddressValid(String value) => value.validateAddress();

  @override
  void dispose() {
    super.dispose();
    _userName = '';
    _mobile = '';
    _pinCode = '';
    _address = '';

    _clearTextField();
  }
}
