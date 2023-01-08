import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/utils.dart';

const String swipeablePageHintKey = 'swipeable_page_hint';
const Duration oneSec = Duration(seconds: 1);

class SwipeablePageHint extends StatefulWidget {
  const SwipeablePageHint({super.key});

  @override
  State<SwipeablePageHint> createState() => _SwipeablePageHintState();
}

class _SwipeablePageHintState extends State<SwipeablePageHint> {
  bool? _showHint;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then(
      (prefs) => setState(
        () => _showHint = prefs.getBool(swipeablePageHintKey),
      ),
    );
  }

  Widget _animatedRightArrow() {
    return Container(
      padding: const EdgeInsets.fromLTRB(7, 0, 7, 1.5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(.5),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.primary.withOpacity(.25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          10,
          (index) => Flash(
            delay: Duration(milliseconds: (index + 1) * 100),
            duration: oneSec,
            infinite: true,
            child: Text(
              '>',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary.withOpacity(.75),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _hintText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(AppText.of(context).swipeablePageHint),
    );
  }

  Widget _dismissButton() {
    return InkWell(
      onTap: () {
        SharedPreferences.getInstance().then(
          (prefs) => prefs.setBool(swipeablePageHintKey, false),
        );
        setState(
          () => _dismissed = true,
        );
      },
      child: Text(
        AppText.of(context).dismiss,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }

  bool _dismissed = false;

  @override
  Widget build(BuildContext context) {
    return _showHint ?? true
        ? FadeOutUp(
            animate: _dismissed,
            duration: const Duration(milliseconds: 500),
            child: Center(
              child: FadeIn(
                duration: oneSec,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _animatedRightArrow(),
                      _hintText(),
                      _dismissButton(),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container(); // show no hint
  }
}
