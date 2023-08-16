import 'dart:math';

import 'package:flutter/material.dart';

class ShakeAnimationWidget extends StatefulWidget {
  final Widget child;
  final double animationOffset;
  final int animationCount;
  final Duration animationDuration;

  const ShakeAnimationWidget({
    super.key,
    required this.child,
    required this.animationOffset,
    this.animationCount = 3,
    this.animationDuration = const Duration(milliseconds: 500),
  });

  @override
  State<ShakeAnimationWidget> createState() =>
      ShakeAnimationWidgetState(animationDuration);
}

class ShakeAnimationWidgetState
    extends AnimationControllerState<ShakeAnimationWidget> {
  ShakeAnimationWidgetState(Duration duration) : super(duration);

  @override
  void initState() {
    super.initState();
    animationController.addStatusListener(_updateStatus);
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }

  void shake() {
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        final sineValue =
            sin(widget.animationCount * 2 * pi * animationController.value);
        return Transform.translate(
          offset: Offset(sineValue * widget.animationOffset, 0),
          child: child,
        );
      },
    );
  }
}

abstract class AnimationControllerState<T extends StatefulWidget>
    extends State<T> with SingleTickerProviderStateMixin {
  AnimationControllerState(this.animationDuration);
  final Duration animationDuration;
  late final animationController =
      AnimationController(vsync: this, duration: animationDuration);

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
