import 'package:flutter/material.dart';
import 'package:foodcafe/utils/extensions.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get to => Get.find();
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  var emailController = TextEditingController();

  String _email = '';

  var _autoValidate = Rx<bool>(false);

  changeEmail(String value) {
    _email = value;
  }

  checkAutoValidate() {
    _autoValidate.value = true;
  }

  Future<void> callForgotPassword() async {
    stateStatus.value = StateStatus.LOADING;

    var param = new Map();
    param['email'] = _email;

    stateStatus.value = StateStatus.SUCCESS;
    _clearTextField();

    Get.back();
  }

  _clearTextField() {
    emailController.clear();
    _email = '';
  }

  String isEmailValid(String value) => value.validateEmail();

  @override
  void dispose() {
    super.dispose();
    _clearTextField();
  }
}
