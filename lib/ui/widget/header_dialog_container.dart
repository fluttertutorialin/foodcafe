import 'package:flutter/material.dart';
import 'package:foodcafe/resource/colors.dart';

class HeaderContainer extends StatelessWidget {
  final Widget child;

  const HeaderContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.4, 0.3),
                colors: [accentColor, notificationBackgroundColor])),
        child: child);
  }
}
