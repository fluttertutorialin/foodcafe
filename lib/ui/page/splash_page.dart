import 'package:flutter/material.dart';
import 'package:foodcafe/controller/controller.dart';
import 'package:foodcafe/resource/style.dart';
import 'package:foodcafe/resource/value.dart';
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
