import 'package:flutter/material.dart';

import '../../theme.dart';
import '../../util/utils.dart';

class SearchText extends StatelessWidget {
  final TextEditingController control;
  final String? hintText;
  final Color? fillColor;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final void Function()? suffixIconTapAction;
  final void Function(String)? onSearchTextChanged;

  const SearchText({
    required this.control,
    this.hintText,
    this.fillColor,
    this.enabledBorder,
    this.focusedBorder,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconTapAction,
    this.onSearchTextChanged,
    super.key,
  });

  final InputBorder _baseBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(16),
    ),
    borderSide: BorderSide(width: 2),
  );

  @override
  Widget build(BuildContext context) {
    final InputBorder enabledInputBorder = enabledBorder ??
        _baseBorder.copyWith(
          borderSide: _baseBorder.borderSide.copyWith(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
          ),
        );
    final InputBorder focusedInputBorder = focusedBorder ??
        _baseBorder.copyWith(
          borderSide: _baseBorder.borderSide.copyWith(
            color: AppColor.lightShade,
          ),
        );

    return TextField(
      controller: control,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ?? Theme.of(context).scaffoldBackgroundColor,
        hintText: hintText ?? AppText.of(context).enterSearchTerm,
        enabledBorder: enabledInputBorder,
        focusedBorder: focusedInputBorder,
        prefixIcon: prefixIcon ??
            Icon(
              Icons.search_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
        suffixIcon: GestureDetector(
          onTap: suffixIconTapAction,
          child: suffixIcon ??
              Icon(
                Icons.clear_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ),
      onChanged: onSearchTextChanged,
      textInputAction: TextInputAction.search,
    );
  }
}
