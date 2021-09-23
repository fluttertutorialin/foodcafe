import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../resource/colors.dart';
import '../../resource/images.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';
import '../../utils/extensions.dart';

class ChangePasswordPage extends StatelessWidget {
  final _key = GlobalKey<FormState>();

  ChangePasswordPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          backgroundColor: appBarColor,
          elevation: appBarElevation,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(backIcon, size: 18, color: appBarTitleColor)),
          title: Text(titleChangePassword, style: appBarTitleStyle)),
      body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _key,
          child: ListView(children: [_formUI()])));

  _formUI() => Container(
      padding: const EdgeInsets.all(20),
      child: Column(children: <Widget>[
        size(heightScale: 30.0),
        _newPasswordInput(),
        _newConfirmPasswordInput(),
        _currentPasswordInput(),
        size(heightScale: 20.0),
        _changePasswordPress(),
        const SizedBox(height: 10.0)
      ]));

  _changePasswordPress() =>
      const Align(alignment: Alignment.bottomCenter).customFloatForm(
          color: appBarTitleColor,
          stateStatus: ChangePasswordController.to.stateStatus.value,
          icon: Icons.navigate_next,
          isMini: false,
          qrCallback: () => _changePasswordValidate());

  _changePasswordValidate() {
    FocusScope.of(Get.context).requestFocus(FocusNode());

    switch (_key.currentState.validate()) {
      case true:
        _key.currentState.save();
        ChangePasswordController.to.callChangePassword();
        break;
      case false:
        ChangePasswordController.to.checkAutoValidate();
        break;
    }
  }

  _newPasswordInput() => inputField(
      ChangePasswordController.to.newPasswordController,
      labelText: hintNewPassword,
      validation: ChangePasswordController.to.isNewPasswordValid,
      obscureText: ChangePasswordController.to.passwordVisible.value,
      onChanged: ChangePasswordController.to.newPassword,
      maxLength: passwordMaxLength,
      inkWell: InkWell(
          child: Icon(ChangePasswordController.to.passwordVisible.value
              ? passwordInVisibleIcon
              : passwordVisibleIcon),
          onTap: () => ChangePasswordController.to.togglePasswordVisibility()));

  _newConfirmPasswordInput() =>
      inputField(ChangePasswordController.to.newConfirmPasswordController,
          labelText: hintNewConfirmPassword, validation: (value) {
        return value.isEmpty
            ? 'New confirm password is required'
            : value == ChangePasswordController.to.newPasswordController.text
                ? null
                : 'New Password and new confirm password not match';
      },
          obscureText: ChangePasswordController.to.passwordVisible.value,
          onChanged: ChangePasswordController.to.newConfirmPassword,
          maxLength: passwordMaxLength,
          inkWell: InkWell(
              child: Icon(ChangePasswordController.to.passwordVisible.value
                  ? passwordInVisibleIcon
                  : passwordVisibleIcon),
              onTap: () =>
                  ChangePasswordController.to.togglePasswordVisibility()));

  _currentPasswordInput() => inputField(
      ChangePasswordController.to.currentPasswordController,
      labelText: hintCurrentPassword,
      validation: ChangePasswordController.to.isCurrentPasswordValid,
      obscureText: ChangePasswordController.to.passwordVisible.value,
      onChanged: ChangePasswordController.to.newPassword,
      maxLength: passwordMaxLength,
      inkWell: InkWell(
          child: Icon(ChangePasswordController.to.passwordVisible.value
              ? passwordInVisibleIcon
              : passwordVisibleIcon),
          onTap: () => ChangePasswordController.to.togglePasswordVisibility()));
}
