import 'package:flutter/material.dart';
import 'package:foodcafe/controller/forgot_password_controller.dart';
import 'package:foodcafe/resource/colors.dart';
import 'package:foodcafe/resource/images.dart';
import 'package:foodcafe/resource/style.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:get/get.dart';
import 'package:foodcafe/utils/extensions.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var _key = GlobalKey<FormState>();

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
      padding: EdgeInsets.all(20),
      child: Column(children: <Widget>[
        widget.size(heightScale: 100.0),
        _formIcon(),
        Text(titleForgotPassword, style: appBarTitleStyle),
        Text(labelForgotPassword,
            textAlign: TextAlign.center, style: appBarSubTitleStyle),
        widget.size(heightScale: 30.0),
        _emailInput(),
        widget.size(heightScale: 20.0),
        _forgotPasswordPress(),
      ])));

  _formIcon() => Center(
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset(appIconImage)));

  _forgotPasswordPress() =>
      Align(alignment: Alignment.bottomCenter).customFloatForm(
          color: appBarTitleColor,
          stateStatus: ForgotPasswordController.to.stateStatus.value,
          icon: Icons.navigate_next,
          isMini: false,
          qrCallback: () => _forgotPasswordValidate());

  _forgotPasswordValidate() {
    FocusScope.of(context).requestFocus(FocusNode());

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

  _emailInput() => widget.inputField(ForgotPasswordController.to.emailController,
      validation: ForgotPasswordController.to.isEmailValid,
      onChanged: ForgotPasswordController.to.changeEmail,
      labelText: hintEmail,
      keyboardType: TextInputType.emailAddress);
}
