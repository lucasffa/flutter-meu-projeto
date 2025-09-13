// lib/presentation/atoms/app_logo.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';

enum AppLogoSize { small, medium, large }
enum AppLogoVariant { full, iconOnly, textOnly, svg }

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = AppLogoSize.medium,
    this.variant = AppLogoVariant.full,
    this.color,
    this.height,
    this.width,
    this.svgAsset = 'assets/images/ifood-logo.svg',
  });

  final AppLogoSize size;
  final AppLogoVariant variant;
  final Color? color;
  final double? height;
  final double? width;
  final String svgAsset;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case AppLogoVariant.full:
        return _buildFullLogo();
      case AppLogoVariant.iconOnly:
        return _buildIconOnly();
      case AppLogoVariant.textOnly:
        return _buildTextOnly();
      case AppLogoVariant.svg:
        return _buildSvgLogo();
    }
  }

  Widget _buildFullLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIcon(),
        SizedBox(width: _getSpacing()),
        _buildText(),
      ],
    );
  }

  Widget _buildIconOnly() {
    return _buildIcon();
  }

  Widget _buildTextOnly() {
    return _buildText();
  }

  Widget _buildSvgLogo() {
    return SvgPicture.asset(
      svgAsset,
      width: width ?? _getIconSize(),
      height: height ?? _getIconSize(),
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
    );
  }

  Widget _buildIcon() {
    return Container(
      width: width ?? _getIconSize(),
      height: height ?? _getIconSize(),
      decoration: BoxDecoration(
        color: color ?? AppColors.primaryRed,
        borderRadius: BorderRadius.circular(_getIconBorderRadius()),
      ),
      child: Center(
        child: Text(
          'i',
          style: TextStyle(
            fontSize: _getIconFontSize(),
            fontWeight: FontWeight.w900,
            color: AppColors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'i',
            style: TextStyle(
              fontSize: _getTextFontSize(),
              fontWeight: FontWeight.w800,
              color: color ?? AppColors.primaryRed,
              fontStyle: FontStyle.italic,
            ),
          ),
          TextSpan(
            text: 'Food',
            style: TextStyle(
              fontSize: _getTextFontSize(),
              fontWeight: FontWeight.w800,
              color: color ?? AppColors.primaryRed,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  double _getIconSize() {
    switch (size) {
      case AppLogoSize.small:
        return AppDimensions.logoHeightSm;
      case AppLogoSize.medium:
        return AppDimensions.logoHeightMd;
      case AppLogoSize.large:
        return AppDimensions.logoHeightLg;
    }
  }

  double _getIconBorderRadius() {
    switch (size) {
      case AppLogoSize.small:
        return AppDimensions.radiusXs;
      case AppLogoSize.medium:
        return AppDimensions.radiusSm;
      case AppLogoSize.large:
        return AppDimensions.radiusMd;
    }
  }

  double _getIconFontSize() {
    switch (size) {
      case AppLogoSize.small:
        return 16.0;
      case AppLogoSize.medium:
        return 24.0;
      case AppLogoSize.large:
        return 32.0;
    }
  }

  double _getTextFontSize() {
    switch (size) {
      case AppLogoSize.small:
        return 16.0;
      case AppLogoSize.medium:
        return 24.0;
      case AppLogoSize.large:
        return 32.0;
    }
  }

  double _getSpacing() {
    switch (size) {
      case AppLogoSize.small:
        return AppDimensions.spacingXs;
      case AppLogoSize.medium:
        return AppDimensions.spacingSm;
      case AppLogoSize.large:
        return AppDimensions.spacingMd;
    }
  }
}