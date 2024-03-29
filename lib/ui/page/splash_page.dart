import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';

class SplashPage extends StatelessWidget {
  final _splashController = Get.put(SplashController());

  SplashPage({Key key}) : super(key: key);

  @override
  build(BuildContext context) => Scaffold(
          body: Center(
              child: SlideTransition(
                  position: _splashController.offsetAnimation,
                  child: Text(appName, style: splashTitleStyle))));
}
