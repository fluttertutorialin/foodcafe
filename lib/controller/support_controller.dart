import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/extensions.dart';
import '../utils/state_status.dart';

class SupportController extends GetxController {
  var stateStatus = Rx<StateStatus>(StateStatus.initial);

  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var messageController = TextEditingController();

  String _userName = '', _email = '', _mobile = '', _message = '';

  final _autoValidate = Rx<bool>(false);

  changeUserName(String value) {
    _userName = value;
  }

  changeEmail(String value) {
    _email = value;
  }

  changeMobile(String value) {
    _mobile = value;
  }

  changeMessage(String value) {
    _message = value;
  }

  checkAutoValidate() {
    _autoValidate.value = true;
  }

  Future<void> callSupport() async {
    stateStatus.value = StateStatus.loading;
    var param = {};
    param['userName'] = _userName;
    param['email'] = _email;
    param['mobile'] = _mobile;
    param['message'] = _message;

    _clearTextField();
    stateStatus.value = StateStatus.success;
  }

  _clearTextField() {
    userNameController.clear();
    emailController.clear();
    mobileController.clear();
  }

  String isUserNameValid(String value) => value.validUserName();

  String isEmailValid(String value) => value.validateEmail();

  String isMobileValid(String value) => value.validateMobile();

  String isMessageValid(String value) => value.validateMessage();

  @override
  void dispose() {
    super.dispose();

    _userName = '';
    _email = '';
    _mobile = '';

    userNameController.text = '';
    emailController.text = '';
    mobileController.text = '';
  }
}
