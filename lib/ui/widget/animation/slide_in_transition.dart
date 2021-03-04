import 'package:flutter/material.dart';

class SlideInController extends AnimationController {
  SlideInController({
    @required TickerProvider vsync,
    Duration duration = const Duration(milliseconds: 700),
  }) : super(vsync: vsync, duration: duration);
}

class SlideInTransition extends StatelessWidget {
  final Widget child;
  final SlideInController controller;
  final Animation<double> _opacity;
  final Animation<Offset> _position;

  SlideInTransition({
    Key key,
    @required this.controller,
    @required this.child,
  })  : _opacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(controller),
        _position =
            Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero)
                .animate(CurvedAnimation(
                    curve: Curves.elasticInOut, parent: controller)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
            opacity: _opacity,
            child: SlideTransition(position: _position, child: child),
          );
        },
        child: child);
  }
}
