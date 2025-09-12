// lib/presentation/atoms/app_button.dart
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';

enum AppButtonVariant { primary, secondary, text, outline }
enum AppButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.leftIcon,
    this.rightIcon,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.elevation,
  });

  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final double? width;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    final isEnabled = !isDisabled && !isLoading && onPressed != null;
    
    return SizedBox(
      width: width,
      height: _getHeight(),
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: _getButtonStyle(),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return SizedBox(
        width: _getIconSize(),
        height: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(_getTextColor()),
        ),
      );
    }

    final children = <Widget>[];
    
    if (leftIcon != null) {
      children.add(leftIcon!);
      children.add(SizedBox(width: AppDimensions.spacingXs));
    }
    
    children.add(
      Text(
        text,
        style: _getTextStyle(),
        textAlign: TextAlign.center,
      ),
    );
    
    if (rightIcon != null) {
      children.add(SizedBox(width: AppDimensions.spacingXs));
      children.add(rightIcon!);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  ButtonStyle _getButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: _getBackgroundColor(),
      foregroundColor: _getTextColor(),
      elevation: elevation ?? _getElevation(),
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? _getBorderRadius()),
        side: _getBorderSide(),
      ),
      padding: _getPadding(),
    );
  }

  Color _getBackgroundColor() {
    if (backgroundColor != null) return backgroundColor!;
    
    switch (variant) {
      case AppButtonVariant.primary:
        return AppColors.primaryRed;
      case AppButtonVariant.secondary:
        return AppColors.grey200;
      case AppButtonVariant.text:
        return Colors.transparent;
      case AppButtonVariant.outline:
        return Colors.transparent;
    }
  }

  Color _getTextColor() {
    if (textColor != null) return textColor!;
    
    switch (variant) {
      case AppButtonVariant.primary:
        return AppColors.textOnPrimary;
      case AppButtonVariant.secondary:
        return AppColors.textPrimary;
      case AppButtonVariant.text:
        return AppColors.primaryRed;
      case AppButtonVariant.outline:
        return AppColors.primaryRed;
    }
  }

  BorderSide _getBorderSide() {
    switch (variant) {
      case AppButtonVariant.outline:
        return BorderSide(
          color: borderColor ?? AppColors.primaryRed,
          width: AppDimensions.borderThin,
        );
      default:
        return BorderSide.none;
    }
  }

  double _getHeight() {
    switch (size) {
      case AppButtonSize.small:
        return AppDimensions.buttonHeightSm;
      case AppButtonSize.medium:
        return AppDimensions.buttonHeightMd;
      case AppButtonSize.large:
        return AppDimensions.buttonHeightLg;
    }
  }

  double _getBorderRadius() {
    switch (size) {
      case AppButtonSize.small:
        return AppDimensions.radiusXs;
      case AppButtonSize.medium:
        return AppDimensions.radiusSm;
      case AppButtonSize.large:
        return AppDimensions.radiusMd;
    }
  }

  double _getElevation() {
    switch (variant) {
      case AppButtonVariant.primary:
        return 2.0;
      case AppButtonVariant.secondary:
        return 1.0;
      case AppButtonVariant.text:
      case AppButtonVariant.outline:
        return 0.0;
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppButtonSize.small:
        return AppDimensions.iconSm;
      case AppButtonSize.medium:
        return AppDimensions.iconMd;
      case AppButtonSize.large:
        return AppDimensions.iconLg;
    }
  }

  TextStyle _getTextStyle() {
    final fontSize = size == AppButtonSize.small ? 12.0 : 
                    size == AppButtonSize.medium ? 14.0 : 16.0;
    
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: _getTextColor(),
    );
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingSm,
          vertical: AppDimensions.spacingXs,
        );
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingMd,
          vertical: AppDimensions.spacingSm,
        );
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingLg,
          vertical: AppDimensions.spacingMd,
        );
    }
  }
}