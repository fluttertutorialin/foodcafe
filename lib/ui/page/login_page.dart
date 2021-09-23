import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../resource/colors.dart';
import '../../resource/images.dart';
import '../../resource/routes.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';
import '../../utils/extensions.dart';

class LoginPage extends StatelessWidget {
  final _key = GlobalKey<FormState>();

  LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _key,
          child: ListView(children: [_formUI()])));

  _formUI() => Obx(() => Container(
      padding: EdgeInsets.all(50.r),
      child: Column(children: <Widget>[
        size(heightScale: Get.height / 10),
        _formIcon(),
        size(heightScale: 30.0.h),
        _emailInput(),
        _passwordInput(),
        size(heightScale: 30.0.h),
        _loginPress(),
        SizedBox(height: 10.0.h),
        _login()
      ])));

  _login() => Column(children: <Widget>[
        RawMaterialButton(
            padding: EdgeInsets.all(10.h),
            child: Text(linkForgotPassword, style: loginLinkStyle(linkColor)),
            onPressed: () => Get.toNamed(forgotPasswordRoute)),
        SizedBox(height: 30.0.h),
        _socialLogin(),
        SizedBox(height: 20.0.h),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(labelSignUp, style: doNotHaveAccountStyle(Colors.black)),
          RawMaterialButton(
              padding: EdgeInsets.all(10.h),
              child: Text(linkSignUp, style: loginLinkStyle(linkColor)),
              onPressed: () => LoginController.to.signUpLink())
        ])
      ]);

  _formIcon() => Center(
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset(appIconImage)));

  _loginPress() => const Align(alignment: Alignment.bottomCenter).customFloatForm(
      color: appBarTitleColor,
      stateStatus: LoginController.to.stateStatus.value,
      icon: Icons.navigate_next,
      isMini: false,
      qrCallback: () => _loginValidate());

  _loginValidate() {
    FocusScope.of(Get.context).requestFocus(FocusNode());

    switch (_key.currentState.validate()) {
      case true:
        _key.currentState.save();
        LoginController.to.callLogin();
        break;
      case false:
        //_loginController.checkAutoValidate();
        LoginController.to.callLogin();
        break;
    }
  }

  _socialLogin() => SizedBox(
      height: 60,
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        socialIcon(
            icon: Icon(googleIcon, color: socialBackgroundColor, size: 25),
            backgroundColor: googleColor,
            voidCallback: () => LoginController.to.callGoogleLogin()),
        SizedBox(width: 30.h),
        socialIcon(
            icon: Icon(facebookLogin, color: socialBackgroundColor, size: 25),
            backgroundColor: facebookColor,
            voidCallback: () => LoginController.to.callFacebookLogin())
      ]));

  _emailInput() => inputField(LoginController.to.emailController,
      validation: LoginController.to.isEmailValid,
      onChanged: LoginController.to.changeEmail,
      labelText: hintEmail,
      keyboardType: TextInputType.emailAddress);

  _passwordInput() => inputField(LoginController.to.passwordController,
      labelText: hintPassword,
      validation: LoginController.to.isPasswordValid,
      obscureText: LoginController.to.passwordVisible.value,
      onChanged: LoginController.to.changePassword,
      maxLength: passwordMaxLength,
      inkWell: InkWell(
          child: Icon(LoginController.to.passwordVisible.value
              ? passwordInVisibleIcon
              : passwordVisibleIcon),
          onTap: () => LoginController.to.togglePasswordVisibility()));
}
