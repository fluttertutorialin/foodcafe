import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import '../resource/api.dart';
import '../resource/routes.dart';
import '../shared/repository/local_auth_repository.dart';

class SplashController extends GetxController
    with SingleGetTickerProviderMixin {
  static SplashController get to => Get.find();

  final _localAuthRepository = Get.find<LocalAuthRepository>();
  AnimationController _controller;
  Animation<Offset> offsetAnimation;

  @override
  void onInit() {
    super.onInit();

    _controller = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    offsetAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, -0.8)).animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate));
    _controller.forward().then((value) => _controller.reverse());
  }

  @override
  void onReady() {
    super.onReady();
    _launchPage();
  }

  _launchPage() async {
    var _onBoarding =
        _localAuthRepository.hasDataSession(secureStorageOnBoarding);
    var _whereLogin =
        _localAuthRepository.hasDataSession(secureStorageWhereLogin);

    await Future.delayed(const Duration(seconds: 3), () {});
    Get.offNamed(_onBoarding
        ? _whereLogin
            ? homeRoute
            : loginRoute
        : onBoardingRoute);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
