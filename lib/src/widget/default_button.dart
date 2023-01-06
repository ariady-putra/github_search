import 'package:flutter/material.dart';

enum DefaultButtonHierarchy {
  primary,
  secondary,
}

class DefaultButton extends StatefulWidget {
  final Function()? tapAction;
  final String label;
  final DefaultButtonHierarchy hierarchy;
  final Color? primaryButtonBackgroundColor;
  final Color? primaryButtonForegroundColor;
  final Color? secondaryButtonBackgroundColor;
  final Color? secondaryButtonForegroundColor;
  final OutlinedBorder? buttonShape;
  final double borderWidth;

  const DefaultButton({
    required this.tapAction,
    required this.label,
    this.hierarchy = DefaultButtonHierarchy.primary,
    this.primaryButtonBackgroundColor,
    this.primaryButtonForegroundColor,
    this.secondaryButtonBackgroundColor,
    this.secondaryButtonForegroundColor,
    this.buttonShape,
    this.borderWidth = 2,
    super.key,
  });

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  Color _primaryButtonBackgroundColor() =>
      widget.primaryButtonBackgroundColor ??
      Theme.of(context).toggleableActiveColor;
  Color _primaryButtonForegroundColor() =>
      widget.primaryButtonForegroundColor ?? Theme.of(context).cardColor;

  Color _secondaryButtonBackgroundColor() =>
      widget.secondaryButtonBackgroundColor ?? Theme.of(context).cardColor;
  Color _secondaryButtonForegroundColor() =>
      widget.secondaryButtonForegroundColor ??
      Theme.of(context).unselectedWidgetColor;

  ButtonStyle? _buttonStyle(DefaultButtonHierarchy buttonHierarcy) {
    switch (buttonHierarcy) {
      // Primary button style
      case DefaultButtonHierarchy.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: _primaryButtonBackgroundColor(),
          foregroundColor: _primaryButtonForegroundColor(),
          side: BorderSide(
            color: _primaryButtonBackgroundColor(),
            width: widget.borderWidth,
          ),
          shape: widget.buttonShape,
        );

      // Secondary button style
      case DefaultButtonHierarchy.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: _secondaryButtonBackgroundColor(),
          foregroundColor: _secondaryButtonForegroundColor(),
          side: BorderSide(
            color: _secondaryButtonForegroundColor(),
            width: widget.borderWidth,
          ),
          shape: widget.buttonShape,
        );

      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _buttonStyle(widget.hierarchy),
      onPressed: widget.tapAction,
      child: Text(widget.label),
    );
  }
}
