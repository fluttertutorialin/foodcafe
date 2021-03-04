import 'package:flutter/material.dart';
import 'package:foodcafe/controller/controller.dart';
import 'package:foodcafe/resource/style.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:get/get.dart';

class OnBoardingPage extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(
          body: Stack(children: [
        PageView.builder(
            onPageChanged: OnBoardingController.to.selectedPage,
            controller: OnBoardingController.to.pageController,
            itemCount: OnBoardingController.to.onBoardingResponseList.length,
            itemBuilder: (context, index) {
              return Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Image.asset(OnBoardingController.to
                        .onBoardingResponseList[index].imageAssets),
                    SizedBox(height: 32),
                    Text(
                        OnBoardingController.to
                            .onBoardingResponseList[index].title,
                        style: onBoardingTitleStyle),
                    SizedBox(height: 20),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 64.0),
                        child: Text(
                            OnBoardingController.to
                                .onBoardingResponseList[index].description,
                            textAlign: TextAlign.center,
                            style: onBoardingMessageStyle))
                  ]));
            }),
        Positioned(
            left: 15,
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    OnBoardingController.to.onBoardingResponseList.length,
                    (index) => Obx(() {
                          return Container(
                              margin: const EdgeInsets.all(3.0),
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                  color: OnBoardingController.to
                                              .selectedPage.value ==
                                          index
                                      ? Colors.red
                                      : Colors.grey,
                                  shape: BoxShape.circle));
                        })))),
        Positioned(
            right: 0,
            bottom: 5,
            child: TextButton(
                child: Obx(() => Text(
                    OnBoardingController.to.isLastPage
                        ? ' $labelStart '
                        : ' $labelNext ',
                    style: btnOnBoardingStyle)),
                onPressed: () => OnBoardingController.to.forwardAction()))
      ]));
}
