import 'package:flutter/material.dart';
import 'package:foodcafe/controller/controller.dart';
import 'package:foodcafe/resource/colors.dart';
import 'package:foodcafe/resource/images.dart';
import 'package:foodcafe/resource/style.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:get/get.dart';
import 'package:foodcafe/utils/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatefulWidget {
  @override
  createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  var _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _key,
          child: ListView(children: [_formUI()])));

  _formUI() => Obx(() => Container(
      padding: EdgeInsets.all(20),
      child: Column(children: <Widget>[
        widget.size(heightScale: Get.height / 12),
        _formIcon(),
        Padding(
            padding: EdgeInsets.all(10.h),
            child: Text(labelSignUpContent,
                textAlign: TextAlign.center, style: appBarTitleStyle)),
        widget.size(heightScale: 30.0.h),
        _userNameInput(),
        _emailInput(),
        _passwordInput(),
        _confirmPassword(),
        _mobileInput(),
        widget.size(heightScale: 30.0.h),
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
    FocusScope.of(context).requestFocus(FocusNode());

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

  _userNameInput() => widget.inputField(SingUpController.to.userNameController,
      validation: SingUpController.to.isUserNameValid,
      onChanged: SingUpController.to.changeUserName,
      labelText: hintUserName,
      keyboardType: TextInputType.text);

  _emailInput() => widget.inputField(SingUpController.to.emailController,
      validation: SingUpController.to.isEmailValid,
      onChanged: SingUpController.to.changeEmail,
      labelText: hintEmail,
      keyboardType: TextInputType.emailAddress);

  _passwordInput() => widget.inputField(SingUpController.to.passwordController,
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
      widget.inputField(SingUpController.to.confirmPasswordController,
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

  _mobileInput() => widget.inputField(SingUpController.to.mobileController,
      validation: SingUpController.to.isMobileValid,
      onChanged: SingUpController.to.changeMobile,
      labelText: hintMobile,
      maxLength: mobileMaxLength,
      keyboardType: TextInputType.number);
}
