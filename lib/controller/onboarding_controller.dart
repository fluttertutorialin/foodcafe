import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import '../model/onboarding/onboarding_response.dart';
import '../resource/api.dart';
import '../resource/routes.dart';
import '../shared/repository/local_auth_repository.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get to => Get.find();
  final _localAuthRepository = Get.find<LocalAuthRepository>();
  var selectedPage = 0.obs;

  bool get isLastPage => selectedPage.value == onBoardingResponseList.length - 1;
  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {
      _localAuthRepository.writeSession(secureStorageOnBoarding, onBoarding);

      Get.offNamedUntil(loginRoute, (_) => false);
    } else {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }

  List<OnBoardingResponse> onBoardingResponseList = [
    OnBoardingResponse(
        imageAssets: 'assets/images/food_cafe.png',
        title: 'Order Your Food',
        description:
            'Now you can order food any time  right from your mobile.'),
    OnBoardingResponse(
        imageAssets: 'assets/images/food_cafe.png',
        title: 'Cooking Safe Food',
        description:
            'We are maintain safty and We keep clean while making food.'),
    OnBoardingResponse(
        imageAssets: 'assets/images/food_cafe.png',
        title: 'Quick Delivery',
        description: 'Orders your favorite meals will be  immediately deliver')
  ];
}
