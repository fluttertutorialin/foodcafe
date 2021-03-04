import 'package:flutter/widgets.dart';
import 'slidable.dart';

const Duration _kResizeDuration = const Duration(milliseconds: 300);

class SlidableDismissal extends StatelessWidget {
  /// Creates a widget that controls how the [Slidable] is dismissed.
  const SlidableDismissal({
    @required this.child,
    this.dismissThresholds = const <SlideActionType, double>{},
    this.onResize,
    this.onDismissed,
    this.resizeDuration = _kResizeDuration,
    this.crossAxisEndOffset = 0.0,
    this.onWillDismiss,
    this.closeOnCanceled = false,
    this.dragDismissible = true,
  }) : assert(dismissThresholds != null);

  final bool dragDismissible;
  final Map<SlideActionType, double> dismissThresholds;
  final DismissSlideActionCallback onDismissed;
  final SlideActionWillBeDismissed onWillDismiss;
  final bool closeOnCanceled;
  final VoidCallback onResize;
  final Duration resizeDuration;
  final double crossAxisEndOffset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final SlidableData data = SlidableData.of(context);

    return AnimatedBuilder(
        animation: data.overallMoveAnimation,
        child: child,
        builder: (BuildContext context, Widget child) {
          if (data.overallMoveAnimation.value > data.totalActionsExtent) {
            return child;
          } else {
            return data.slidable.actionPane;
          }
        });
  }
}

class SlidableDrawerDismissal extends StatelessWidget {
  const SlidableDrawerDismissal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SlidableData data = SlidableData.of(context);

    final animation = Tween<Offset>(
      begin: Offset.zero,
      end: data.createOffset(data.actionSign),
    ).animate(data.overallMoveAnimation);

    final count = data.actionCount;

    final extentAnimations = Iterable.generate(count).map((index) {
      return Tween<double>(
        begin: data.actionExtentRatio,
        end: 1 - data.actionExtentRatio * (data.actionCount - index - 1),
      ).animate(CurvedAnimation(
          parent: data.overallMoveAnimation,
          curve: Interval(data.totalActionsExtent, 1.0)));
    }).toList();

    return Stack(children: <Widget>[
      AnimatedBuilder(
          animation: data.overallMoveAnimation,
          builder: (context, child) {
            return Positioned.fill(
                child: Stack(
                    children: List.generate(data.actionCount, (index) {
              int displayIndex =
                  data.showActions ? data.actionCount - index - 1 : index;

              return data.createFractionallyAlignedSizedBox(
                  positionFactor:
                      data.actionExtentRatio * (data.actionCount - index - 1),
                  extentFactor: extentAnimations[index].value,
                  child: data.actionDelegate.build(context, displayIndex,
                      data.actionsMoveAnimation, data.renderingMode));
            })));
          }),
      SlideTransition(position: animation, child: data.slidable.child)
    ]);
  }
}
