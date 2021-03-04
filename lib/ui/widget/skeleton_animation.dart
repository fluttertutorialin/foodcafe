import 'package:flutter/material.dart';

/*
ListTile(
                    title: SkeletonAnimation(
                      width: 200,
                      height: 14,
                      radius: Radius.circular(6),
                    ),
*/

class SkeletonAnimation extends StatefulWidget {
  final Color baseColor;
  final Color hightlightColor;
  final double width;
  final double height;
  final Radius radius;

  SkeletonAnimation({
    this.baseColor = const Color(0xFFE0E0E0),
    this.hightlightColor = const Color(0xFFeaeaea),
    // Use default size
    this.width = 200.0,
    this.height = 60.0,
    // Use default radius
    this.radius = const Radius.circular(0),
  });

  @override
  _SkeletonAnimationState createState() => _SkeletonAnimationState();
}

class _SkeletonAnimationState extends State<SkeletonAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addStatusListener((AnimationStatus status) {
        if (status != AnimationStatus.completed) {
          return;
        }
        _controller.repeat();
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(widget.radius),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      widget.baseColor,
                      widget.hightlightColor,
                      widget.baseColor
                    ],
                    stops: [
                      // Animate using the controller value (0 - 1)
                      _generateValue(
                          percentage: _controller.value, value: 0.35),
                      _generateValue(percentage: _controller.value, value: 0.5),
                      _generateValue(percentage: _controller.value, value: 0.65)
                    ]))));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Generate the value for the loading animation
  double _generateValue({percentage: double, value: double}) {
    double tmp = (percentage * 1.3) - 0.65 + value;

    if (tmp < 0) {
      return 0;
    } else if (tmp > 1) {
      return 1;
    } else {
      return tmp;
    }
  }
}
