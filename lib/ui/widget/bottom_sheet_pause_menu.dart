import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pause_menu_order_on_off_timer.dart';
import '../../resource/colors.dart';
import '../../resource/font.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';

class BottomSheetPauseMenu extends StatelessWidget {
  final String menuName;
  final VoidCallback voidCallbackOk;

  BottomSheetPauseMenu(
      {@required this.menuName, @required this.voidCallbackOk});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      SizedBox(height: 20),
      Text(menuName, style: bottomSheetPauseMenuTitleStyle),
      SizedBox(height: 10),
      Text(
          'You will not receive orders for \n this item till day end from now.',
          textAlign: TextAlign.center,
          style: bottomSheetPauseMenuDescriptionStyle),
      SizedBox(height: 30),
      PauseMenuOrderOffTimer(),
      SizedBox(height: 30),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: Get.width / 3),
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10, bottom: 10))),
                onPressed: () => Get.back(),
                child: Text(cancelButton,
                    style: TextStyle(fontFamily: mediumFont, fontSize: 15)))),
        SizedBox(width: 30),
        ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: Get.width / 3),
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(btnOkColor),
                    padding: MaterialStateProperty.all(EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10, bottom: 10))),
                onPressed: () => voidCallbackOk(),
                child: Text(okButton,
                    style: TextStyle(
                        fontFamily: mediumFont,
                        color: Colors.white,
                        fontSize: 15)))),
        SizedBox(height: 20)
      ])
    ]));
  }
}
