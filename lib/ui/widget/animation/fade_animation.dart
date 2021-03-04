/*
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

*/
/*
 FadeAnimation((1 + 0.5 * index), Container())
*//*

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;
  FadeAnimation(this.delay, this.child);
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track('opacity')
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track('translateY').add(
          Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
          curve: Curves.easeOut),
    ]);

    return ControlledAnimation(
        builderWithChild: (context, child, value) => Opacity(
            opacity: value['opacity'],
            child: Transform.translate(
                offset: Offset(0, value['translateY']), child: child)),
        child: child,
        tween: tween,
        duration: tween.duration,
        delay: Duration(milliseconds: (500 * delay).round()));
  }
}
*/
