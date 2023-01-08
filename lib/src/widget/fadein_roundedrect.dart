import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class FadeInRoundedRect extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double borderRadius;
  final double padding;
  final int fadeDelaySec;
  final int fadeDurationSec;

  const FadeInRoundedRect({
    required this.child,
    this.color,
    this.borderRadius = 16,
    this.padding = 20,
    this.fadeDelaySec = 0,
    this.fadeDurationSec = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: Duration(seconds: fadeDelaySec),
      duration: Duration(seconds: fadeDurationSec),
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: color ?? Colors.white.withOpacity(.25),
        ),
        child: child,
      ),
    );
  }
}
