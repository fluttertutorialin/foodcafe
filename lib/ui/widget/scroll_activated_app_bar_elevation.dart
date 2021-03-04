import 'package:flutter/widgets.dart';

typedef BuilderWithElevation = Widget Function(
    BuildContext context, double appBarElevation);

class ScrollActivatedAppBarElevation extends StatefulWidget {
  const ScrollActivatedAppBarElevation({
    @required this.builder,
    this.elevationInitial = 0,
    this.elevationScrolled = 4,
    Key key,
  })  : assert(builder != null),
        assert(elevationInitial != null),
        assert(elevationScrolled != null),
        super(key: key);

  final double elevationInitial;
  final double elevationScrolled;
  final BuilderWithElevation builder;

  @override
  _ScrollActivatedAppBarElevationState createState() =>
      _ScrollActivatedAppBarElevationState();
}

class _ScrollActivatedAppBarElevationState
    extends State<ScrollActivatedAppBarElevation> {
  double _appBarElevation;

  @override
  void initState() {
    super.initState();
    _appBarElevation = widget.elevationInitial;
  }

  @override
  Widget build(BuildContext context) => NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          final scrolledPixels = notification.metrics.extentBefore;
          final newElevation = scrolledPixels > 1
              ? widget.elevationScrolled
              : widget.elevationInitial;
          if (_appBarElevation != newElevation) {
            setState(() {
              _appBarElevation = newElevation;
            });
          }
        }
        return false;
      },
      child: widget.builder(context, _appBarElevation));
}
