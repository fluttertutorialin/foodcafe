import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Stack(children: [
        PageView.builder(
            onPageChanged: OnBoardingController.to.selectedPage,
            controller: OnBoardingController.to.pageController,
            itemCount: OnBoardingController.to.onBoardingResponseList.length,
            itemBuilder: (context, index) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Image.asset(OnBoardingController.to
                    .onBoardingResponseList[index].imageAssets),
                const SizedBox(height: 32),
                Text(
                    OnBoardingController.to
                        .onBoardingResponseList[index].title,
                    style: onBoardingTitleStyle),
                const SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64.0),
                    child: Text(
                        OnBoardingController.to
                            .onBoardingResponseList[index].description,
                        textAlign: TextAlign.center,
                        style: onBoardingMessageStyle))
              ]);
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
