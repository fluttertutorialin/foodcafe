import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodcafe/resource/font.dart';
import 'slidable.dart';

const bool _kCloseOnTap = true;

abstract class ClosableSlideAction extends StatelessWidget {
  const ClosableSlideAction({
    Key key,
    this.color,
    this.onTap,
    this.closeOnTap = _kCloseOnTap,
  })  : assert(closeOnTap != null),
        super(key: key);

  final Color color;
  final VoidCallback onTap;
  final bool closeOnTap;

  void _handleCloseAfterTap(BuildContext context) {
    onTap?.call();
    Slidable.of(context)?.close();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Material(
            color: color,
            child: InkWell(
                onTap:
                    !closeOnTap ? onTap : () => _handleCloseAfterTap(context),
                child: buildAction(context))));
  }

  @protected
  Widget buildAction(BuildContext context);
}

class SlideAction extends ClosableSlideAction {
  SlideAction({
    Key key,
    @required this.child,
    VoidCallback onTap,
    Color color,
    Decoration decoration,
    bool closeOnTap = _kCloseOnTap,
  })  : assert(child != null),
        assert(decoration == null || decoration.debugAssertIsValid()),
        assert(
            color == null || decoration == null,
            'Cannot provide both a color and a decoration\n'
            'The color argument is just a shorthand for "decoration:  BoxDecoration(color: color)".'),
        decoration =
            decoration ?? (color != null ? BoxDecoration(color: color) : null),
        super(
            key: key,
            onTap: onTap,
            closeOnTap: closeOnTap,
            color: color ?? Colors.transparent);

  final Decoration decoration;
  final Widget child;

  @override
  Widget buildAction(BuildContext context) {
    return Container(decoration: decoration, child: Center(child: child));
  }
}

class IconSlideAction extends ClosableSlideAction {
  const IconSlideAction({
    Key key,
    this.icon,
    this.iconWidget,
    this.caption,
    Color color,
    this.foregroundColor,
    VoidCallback onTap,
    bool closeOnTap = _kCloseOnTap,
  })  : color = color ?? Colors.white,
        super(key: key, color: color, onTap: onTap, closeOnTap: closeOnTap);

  final IconData icon;
  final Widget iconWidget;
  final String caption;
  final Color color;
  final Color foregroundColor;

  @override
  Widget buildAction(BuildContext context) {
    final Color estimatedColor =
        ThemeData.estimateBrightnessForColor(color) == Brightness.light
            ? Colors.black
            : Colors.white;

    final List<Widget> widgets = [];

    if (icon != null) {
      widgets.add(Flexible(
          child: Icon(icon, color: foregroundColor ?? estimatedColor)));
    }

    if (iconWidget != null) {
      widgets.add(Flexible(child: iconWidget));
    }

    if (caption != null) {
      widgets.add(Flexible(
          child: Text(caption,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white ?? estimatedColor,
                  fontSize: 16,
                  fontFamily: semiBoldFont))));
    }

    return Container(
        child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: widgets)));
  }
}
