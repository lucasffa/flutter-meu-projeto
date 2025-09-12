// lib/presentation/molecules/brand_header.dart
import 'package:flutter/material.dart';
import '../atoms/app_logo.dart';
import '../atoms/app_text.dart';
import '../../core/constants/app_dimensions.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({
    super.key,
    this.title,
    this.subtitle,
    this.logoSize = AppLogoSize.medium,
    this.logoVariant = AppLogoVariant.full,
    this.titleVariant = AppTextVariant.titleLarge,
    this.subtitleVariant = AppTextVariant.bodyMedium,
    this.spacing,
    this.titleSpacing,
    this.alignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.logoColor,
    this.titleColor,
    this.subtitleColor,
    this.showLogo = true,
  });

  final String? title;
  final String? subtitle;
  final AppLogoSize logoSize;
  final AppLogoVariant logoVariant;
  final AppTextVariant titleVariant;
  final AppTextVariant subtitleVariant;
  final double? spacing;
  final double? titleSpacing;
  final MainAxisAlignment alignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Color? logoColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final bool showLogo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: alignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLogo) ...[
          AppLogo(
            size: logoSize,
            variant: logoVariant,
            color: logoColor,
          ),
          if (title != null || subtitle != null)
            SizedBox(height: spacing ?? _getDefaultSpacing()),
        ],
        if (title != null) ...[
          AppText(
            title!,
            variant: titleVariant,
            color: titleColor,
            textAlign: _getTextAlign(),
          ),
          if (subtitle != null)
            SizedBox(height: titleSpacing ?? _getDefaultTitleSpacing()),
        ],
        if (subtitle != null)
          AppText(
            subtitle!,
            variant: subtitleVariant,
            color: subtitleColor,
            textAlign: _getTextAlign(),
          ),
      ],
    );
  }

  TextAlign _getTextAlign() {
    switch (crossAxisAlignment) {
      case CrossAxisAlignment.start:
        return TextAlign.start;
      case CrossAxisAlignment.end:
        return TextAlign.end;
      case CrossAxisAlignment.center:
        return TextAlign.center;
      default:
        return TextAlign.center;
    }
  }

  double _getDefaultSpacing() {
    switch (logoSize) {
      case AppLogoSize.small:
        return AppDimensions.spacingMd;
      case AppLogoSize.medium:
        return AppDimensions.spacingLg;
      case AppLogoSize.large:
        return AppDimensions.spacingXl;
    }
  }

  double _getDefaultTitleSpacing() {
    return AppDimensions.spacingXs;
  }
}