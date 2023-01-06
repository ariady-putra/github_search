import 'dart:math';

import 'package:flutter/material.dart';

class RadioButton<T> extends StatelessWidget {
  final String title;
  final T value;
  final T groupValue;
  final void Function(T?)? onChanged;

  const RadioButton({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;
    final double padSize = min(16, MediaQuery.of(context).size.width / 30);

    return InkWell(
      onTap: () {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      child: Row(
        children: [
          Radio(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          Text(
            title,
            // style: Theme.of(context).textTheme.caption,
            style: TextStyle(
              color: isSelected
                  ? Theme.of(context).toggleableActiveColor
                  : Theme.of(context).unselectedWidgetColor,
            ),
          ),
          SizedBox(width: padSize),
        ],
      ),
    );
  }
}
