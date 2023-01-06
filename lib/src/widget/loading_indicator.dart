import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Roulette(
      animate: true,
      infinite: true,
      child: Icon(
        Icons.hourglass_empty_outlined,
        color: Theme.of(context).primaryColorDark,
      ),
    );
  }
}
