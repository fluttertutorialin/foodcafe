import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/extensions.dart';
import '../utils/state_status.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get to => Get.find();
  var stateStatus = Rx<StateStatus>(StateStatus.initial);

  var emailController = TextEditingController();

  String _email = '';

  final _autoValidate = Rx<bool>(false);

  changeEmail(String value) {
    _email = value;
  }

  checkAutoValidate() {
    _autoValidate.value = true;
  }

  Future<void> callForgotPassword() async {
    stateStatus.value = StateStatus.loading;

    var param = {};
    param['email'] = _email;

    stateStatus.value = StateStatus.success;
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
