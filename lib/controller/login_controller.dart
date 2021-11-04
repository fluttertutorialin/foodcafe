import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import '../resource/api.dart';
import '../resource/routes.dart';
import '../resource/value.dart';
import '../shared/repository/firestore_database_repository.dart';
import '../utils/extensions.dart';
import '../utils/state_status.dart';
import '../shared/provider/session_store.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  LoginController({this.fireStoreDatabaseRepository, this.sessionStore});

  /// inject repo abstraction dependency
  final SessionStore sessionStore;
  final FireStoreDatabaseRepository fireStoreDatabaseRepository;

  var stateStatus = Rx<StateStatus>(StateStatus.initial);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  String _email = '', _password = '';

  final _autoValidate = Rx<bool>(false);
  var passwordVisible = Rx<bool>(true);

  changeEmail(String value) {
    _email = value;
  }

  changePassword(String value) {
    _password = value;
  }

  checkAutoValidate() {
    _autoValidate.value = true;
  }

  togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  Future<void> callLogin() async {
    NetworkController.to.initConnectivity().then((value) async {
      if (value > netWorkConnectionError) {
        stateStatus.value = StateStatus.loading;

        /*final _loginParam = LoginParam(_email, _password);
    fireStoreDatabaseRepository.login(
      body: _loginParam.toJson(),
        success: (value) {
          stateStatus.value = StateStatus.success;
          print(value);
          /*var loginList =
              value.map((m) => LoginResponse.fromJson(m)).toList();
          print(loginList.length);*/
        },
        error: (value) {
          stateStatus.value = StateStatus.success;
          passwordController.clear();
          _password = '';

          toast(
              title: 'Login error',
              message: value.message,
              textColor: toastMessageOrderColor,
              backgroundColor: toastBackgroundOrderColor,
              flushBarPosition: toastOrderPosition);
        });*/

        sessionStore.userId('');
        sessionStore.token('');
        sessionStore.userName(developerName);
        sessionStore.email(developerEmail);
        sessionStore.profileUrl('');
        sessionStore.mobile('');
        sessionStore.pinCode('123456');
        sessionStore.address('Address');
        sessionStore.whereLogin(whereLogin);
        sessionStore.whereLogin(onBoarding);

        await Future.delayed(const Duration(seconds: 2));
        stateStatus.value = StateStatus.success;
        _clearTextField();

        Get.offNamedUntil(homeRoute, (_) => false);
      }
    });
  }

  Future<void> callGoogleLogin() async {
    sessionStore.whereLogin(onBoarding);
  }

  Future<void> callFacebookLogin() async {
    sessionStore.whereLogin(onBoarding);
    Get.offNamedUntil(homeRoute, (_) => false);
  }

  _clearTextField() {
    if (_email.isNotEmpty || _password.isNotEmpty) {
      emailController.clear();
      passwordController.clear();

      _email = '';
      _password = '';
    }
  }

  signUpLink() => Get.toNamed(signUpRoute);

  String isPasswordValid(String value) => value.validatePassword();

  String isEmailValid(String value) => value.validateEmail();

  @override
  void dispose() {
    super.dispose();
    _clearTextField();
  }
}
