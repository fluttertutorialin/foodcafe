import 'package:flutter/material.dart';
import 'package:foodcafe/controller/controller.dart';
import 'package:foodcafe/utils/extensions.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';

class ProfileEditController extends GetxController {
  static ProfileEditController get to => Get.find();
  var _homeController = Get.put(HomeController());
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  var userNameController = TextEditingController();
  var mobileController = TextEditingController();
  var pinCodeController = TextEditingController();
  var addressController = TextEditingController();

  String _userName = '', _mobile = '', _pinCode = '', _address = '';

  var autoValidate = Rx<bool>(false);
  var profileURL = Rx<String>('');
  var userName = Rx<String>();

  var imagePickerPath = Rx<String>();

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

    userNameController.text = _homeController.secureStorageUserName.value;
    mobileController.text = _homeController.secureStorageMobile.value;
    pinCodeController.text = _homeController.secureStoragePinCode.value;
    addressController.text = _homeController.secureStorageAddress.value;

    profileURL.value = _homeController.secureStorageProfileURL.value;
    userName.value = _homeController.secureStorageUserName.value;
  }

  setImagePickerPath(String path) {
    imagePickerPath.value = path;
  }

  Future<void> callProfile() async {
    stateStatus.value = StateStatus.LOADING;

    _homeController.setUserDetails(
      userName: _userName == ''
          ? _homeController.secureStorageUserName.value
          : _userName,
      mobile:
          _mobile == '' ? _homeController.secureStorageMobile.value : _mobile,
      pinCode: _pinCode == ''
          ? _homeController.secureStoragePinCode.value
          : _pinCode,
      address: _address == ''
          ? _homeController.secureStorageAddress.value
          : _address,
    );
    _homeController.getUserDetails();

    stateStatus.value = StateStatus.SUCCESS;

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
