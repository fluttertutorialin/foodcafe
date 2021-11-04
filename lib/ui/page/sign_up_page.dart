import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/controller.dart';
import '../../resource/colors.dart';
import '../../resource/images.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';
import '../../utils/extensions.dart';

class SignUpPage extends GetView<SingUpController> {
  final _key = GlobalKey<FormState>();

  SignUpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _key,
          child: ListView(children: [_formUI()])));

  _formUI() => Obx(() => Container(
      padding: const EdgeInsets.all(20),
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

  _signUpPress() =>
      const Align(alignment: Alignment.bottomCenter).customFloatForm(
          color: appBarTitleColor,
          stateStatus: controller.stateStatus.value,
          icon: Icons.navigate_next,
          isMini: false,
          qrCallback: () => _signUpValidate());

  _signUpValidate() {
    FocusScope.of(Get.context).requestFocus(FocusNode());

    switch (_key.currentState.validate()) {
      case true:
        _key.currentState.save();
        controller.callSignUp();
        break;
      case false:
        controller.checkAutoValidate();
        break;
    }
  }

  _userNameInput() => inputField(controller.userNameController,
      validation: controller.isUserNameValid,
      onChanged: controller.changeUserName,
      labelText: hintUserName,
      keyboardType: TextInputType.text);

  _emailInput() => inputField(controller.emailController,
      validation: controller.isEmailValid,
      onChanged: controller.changeEmail,
      labelText: hintEmail,
      keyboardType: TextInputType.emailAddress);

  _passwordInput() => inputField(controller.passwordController,
      labelText: hintPassword,
      validation: controller.isPasswordValid,
      obscureText: controller.passwordVisible.value,
      onChanged: controller.changePassword,
      maxLength: passwordMaxLength,
      inkWell: InkWell(
          child: Icon(controller.passwordVisible.value
              ? passwordInVisibleIcon
              : passwordVisibleIcon),
          onTap: () => controller.togglePasswordVisibility()));

  _confirmPassword() => inputField(controller.confirmPasswordController,
          labelText: hintConfirmPassword, validation: (confirmation) {
        return confirmation.isEmpty
            ? 'Confirm password is required'
            : confirmation == controller.passwordController.text
                ? null
                : 'Password and confirm password not match';
      },
          obscureText: controller.passwordVisible.value,
          onChanged: controller.changeConfirmPassword,
          maxLength: passwordMaxLength,
          inkWell: InkWell(
              child: Icon(controller.passwordVisible.value
                  ? passwordInVisibleIcon
                  : passwordVisibleIcon),
              onTap: () => controller.togglePasswordVisibility()));

  _mobileInput() => inputField(controller.mobileController,
      validation: controller.isMobileValid,
      onChanged: controller.changeMobile,
      labelText: hintMobile,
      maxLength: mobileMaxLength,
      keyboardType: TextInputType.number);
}
