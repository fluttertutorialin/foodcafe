import 'package:flutter/material.dart';
import '../../controller/controller.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  @override
  createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  final _splashController = Get.put(SplashController());

  @override
  build(BuildContext context) => Scaffold(
          body: Center(
              child: SlideTransition(
                  position: _splashController.offsetAnimation,
                  child: Text(appName, style: splashTitleStyle))));
}
