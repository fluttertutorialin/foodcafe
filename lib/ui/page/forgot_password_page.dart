import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/forgot_password_controller.dart';
import '../../resource/colors.dart';
import '../../resource/images.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';
import '../../utils/extensions.dart';

class ForgotPasswordPage extends StatelessWidget {
  final _key = GlobalKey<FormState>();

  ForgotPasswordPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      /*FancyBackground(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _key,
              child: ListView(children: [_formUI()]))))*/

      Scaffold(
          body: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _key,
              child: ListView(children: [_formUI()])));

  _formUI() => Obx(() => Container(
      padding: const EdgeInsets.all(20),
      child: Column(children: <Widget>[
        size(heightScale: 100.0),
        _formIcon(),
        Text(titleForgotPassword, style: appBarTitleStyle),
        Text(labelForgotPassword,
            textAlign: TextAlign.center, style: appBarSubTitleStyle),
        size(heightScale: 30.0),
        _emailInput(),
        size(heightScale: 20.0),
        _forgotPasswordPress(),
      ])));

  _formIcon() => Center(
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset(appIconImage)));

  _forgotPasswordPress() =>
      const Align(alignment: Alignment.bottomCenter).customFloatForm(
          color: appBarTitleColor,
          stateStatus: ForgotPasswordController.to.stateStatus.value,
          icon: Icons.navigate_next,
          isMini: false,
          qrCallback: () => _forgotPasswordValidate());

  _forgotPasswordValidate() {
    FocusScope.of(Get.context).requestFocus(FocusNode());

    switch (_key.currentState.validate()) {
      case true:
        _key.currentState.save();
        ForgotPasswordController.to.callForgotPassword();
        break;
      case false:
        ForgotPasswordController.to.checkAutoValidate();
        break;
    }
  }

  _emailInput() => inputField(ForgotPasswordController.to.emailController,
      validation: ForgotPasswordController.to.isEmailValid,
      onChanged: ForgotPasswordController.to.changeEmail,
      labelText: hintEmail,
      keyboardType: TextInputType.emailAddress);
}
