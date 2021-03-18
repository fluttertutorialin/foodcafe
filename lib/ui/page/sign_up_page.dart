import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/controller.dart';
import '../../resource/colors.dart';
import '../../resource/images.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';
import '../../utils/extensions.dart';

class SignUpPage extends StatelessWidget {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _key,
          child: ListView(children: [_formUI()])));

  _formUI() => Obx(() => Container(
      padding: EdgeInsets.all(20),
      child: Column(children: <Widget>[
        size(heightScale: Get.height / 12),
        _formIcon(),
        Padding(
            padding: EdgeInsets.all(10.h),
            child: Text(labelSignUpContent,
                textAlign: TextAlign.center, style: appBarTitleStyle)),
        size(heightScale: 30.0.h),
        _userNameInput(),
        _emailInput(),
        _passwordInput(),
        _confirmPassword(),
        _mobileInput(),
        size(heightScale: 30.0.h),
        _signUpPress(),
        SizedBox(height: 10.0.h)
      ])));

  _formIcon() => Center(
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset(appIconImage)));

  _signUpPress() => Align(alignment: Alignment.bottomCenter).customFloatForm(
      color: appBarTitleColor,
      stateStatus: SingUpController.to.stateStatus.value,
      icon: Icons.navigate_next,
      isMini: false,
      qrCallback: () => _signUpValidate());

  _signUpValidate() {
    FocusScope.of(Get.context).requestFocus(FocusNode());

    switch (_key.currentState.validate()) {
      case true:
        _key.currentState.save();
        SingUpController.to.callSignUp();
        break;
      case false:
        SingUpController.to.checkAutoValidate();
        break;
    }
  }

  _userNameInput() => inputField(SingUpController.to.userNameController,
      validation: SingUpController.to.isUserNameValid,
      onChanged: SingUpController.to.changeUserName,
      labelText: hintUserName,
      keyboardType: TextInputType.text);

  _emailInput() => inputField(SingUpController.to.emailController,
      validation: SingUpController.to.isEmailValid,
      onChanged: SingUpController.to.changeEmail,
      labelText: hintEmail,
      keyboardType: TextInputType.emailAddress);

  _passwordInput() => inputField(SingUpController.to.passwordController,
      labelText: hintPassword,
      validation: SingUpController.to.isPasswordValid,
      obscureText: SingUpController.to.passwordVisible.value,
      onChanged: SingUpController.to.changePassword,
      maxLength: passwordMaxLength,
      inkWell: InkWell(
          child: Icon(SingUpController.to.passwordVisible.value
              ? passwordInVisibleIcon
              : passwordVisibleIcon),
          onTap: () => SingUpController.to.togglePasswordVisibility()));

  _confirmPassword() =>
      inputField(SingUpController.to.confirmPasswordController,
          labelText: hintConfirmPassword, validation: (confirmation) {
        return confirmation.isEmpty
            ? 'Confirm password is required'
            : confirmation == SingUpController.to.passwordController.text
                ? null
                : 'Password and confirm password not match';
      },
          obscureText: SingUpController.to.passwordVisible.value,
          onChanged: SingUpController.to.changeConfirmPassword,
          maxLength: passwordMaxLength,
          inkWell: InkWell(
              child: Icon(SingUpController.to.passwordVisible.value
                  ? passwordInVisibleIcon
                  : passwordVisibleIcon),
              onTap: () => SingUpController.to.togglePasswordVisibility()));

  _mobileInput() => inputField(SingUpController.to.mobileController,
      validation: SingUpController.to.isMobileValid,
      onChanged: SingUpController.to.changeMobile,
      labelText: hintMobile,
      maxLength: mobileMaxLength,
      keyboardType: TextInputType.number);
}
