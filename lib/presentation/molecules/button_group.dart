// lib/presentation/molecules/button_group.dart
import 'package:flutter/material.dart';
import '../atoms/app_button.dart';
import '../../core/constants/app_dimensions.dart';

enum ButtonGroupDirection { horizontal, vertical }
enum ButtonGroupAlignment { start, center, end, spaceBetween, spaceAround, spaceEvenly }

class ButtonGroupItem {
  const ButtonGroupItem({
    required this.text,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.leftIcon,
    this.rightIcon,
    this.flex,
  });

  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final int? flex;
}

class ButtonGroup extends StatelessWidget {
  const ButtonGroup({
    super.key,
    required this.buttons,
    this.direction = ButtonGroupDirection.vertical,
    this.alignment = ButtonGroupAlignment.center,
    this.spacing,
    this.fullWidth = false,
  });

  final List<ButtonGroupItem> buttons;
  final ButtonGroupDirection direction;
  final ButtonGroupAlignment alignment;
  final double? spacing;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    if (direction == ButtonGroupDirection.horizontal) {
      return _buildHorizontalGroup();
    } else {
      return _buildVerticalGroup();
    }
  }

  Widget _buildHorizontalGroup() {
    final children = <Widget>[];
    
    for (int i = 0; i < buttons.length; i++) {
      final button = buttons[i];
      
      Widget buttonWidget = AppButton(
        text: button.text,
        onPressed: button.onPressed,
        variant: button.variant,
        size: button.size,
        isLoading: button.isLoading,
        isDisabled: button.isDisabled,
        leftIcon: button.leftIcon,
        rightIcon: button.rightIcon,
        width: fullWidth ? null : null,
      );

      if (fullWidth && button.flex != null) {
        buttonWidget = Expanded(
          flex: button.flex!,
          child: buttonWidget,
        );
      } else if (fullWidth) {
        buttonWidget = Expanded(child: buttonWidget);
      }

      children.add(buttonWidget);
      
      if (i < buttons.length - 1) {
        children.add(SizedBox(width: spacing ?? _getDefaultSpacing()));
      }
    }

    return Row(
      mainAxisAlignment: _getMainAxisAlignment(),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildVerticalGroup() {
    final children = <Widget>[];
    
    for (int i = 0; i < buttons.length; i++) {
      final button = buttons[i];
      
      Widget buttonWidget = AppButton(
        text: button.text,
        onPressed: button.onPressed,
        variant: button.variant,
        size: button.size,
        isLoading: button.isLoading,
        isDisabled: button.isDisabled,
        leftIcon: button.leftIcon,
        rightIcon: button.rightIcon,
        width: fullWidth ? double.infinity : null,
      );

      children.add(buttonWidget);
      
      if (i < buttons.length - 1) {
        children.add(SizedBox(height: spacing ?? _getDefaultSpacing()));
      }
    }

    return Column(
      mainAxisAlignment: _getMainAxisAlignment(),
      crossAxisAlignment: _getCrossAxisAlignment(),
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  MainAxisAlignment _getMainAxisAlignment() {
    switch (alignment) {
      case ButtonGroupAlignment.start:
        return MainAxisAlignment.start;
      case ButtonGroupAlignment.center:
        return MainAxisAlignment.center;
      case ButtonGroupAlignment.end:
        return MainAxisAlignment.end;
      case ButtonGroupAlignment.spaceBetween:
        return MainAxisAlignment.spaceBetween;
      case ButtonGroupAlignment.spaceAround:
        return MainAxisAlignment.spaceAround;
      case ButtonGroupAlignment.spaceEvenly:
        return MainAxisAlignment.spaceEvenly;
    }
  }

  CrossAxisAlignment _getCrossAxisAlignment() {
    if (fullWidth) return CrossAxisAlignment.stretch;
    
    switch (alignment) {
      case ButtonGroupAlignment.start:
        return CrossAxisAlignment.start;
      case ButtonGroupAlignment.center:
        return CrossAxisAlignment.center;
      case ButtonGroupAlignment.end:
        return CrossAxisAlignment.end;
      default:
        return CrossAxisAlignment.center;
    }
  }

  double _getDefaultSpacing() {
    return AppDimensions.spacingMd;
  }
}