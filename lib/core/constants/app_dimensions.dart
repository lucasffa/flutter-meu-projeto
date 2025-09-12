// lib/core/constants/app_dimensions.dart

///
/// As dimensões possuem medidas em pixels, portanto, não são responsivas.
/// É necessário usar static, sendo que static significa que a variável é uma constante e não pode ser alterada.
/// Utilizei double para as dimensões, pois é a unidade de medida mais comum e mais precisa para o Flutter.
/// 
class AppDimensions {
  // Spacing
  static const double spacing2xs = 4.0;
  static const double spacingXs = 8.0;
  static const double spacingSm = 12.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacing2xl = 48.0;
  static const double spacing3xl = 64.0;

  // Border Radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 9999.0;

  // Border Width
  static const double borderThin = 1.0;
  static const double borderMedium = 2.0;
  static const double borderThick = 3.0;

  // Icon Sizes
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 20.0;
  static const double iconLg = 24.0;
  static const double iconXl = 32.0;
  static const double icon2xl = 48.0;

  // Button Heights
  static const double buttonHeightSm = 32.0;
  static const double buttonHeightMd = 48.0;
  static const double buttonHeightLg = 56.0;

  // Input Heights
  static const double inputHeightSm = 40.0;
  static const double inputHeightMd = 48.0;
  static const double inputHeightLg = 56.0;

  // Container Sizes
  static const double containerMaxWidth = 400.0;
  static const double containerPadding = spacingLg;

  // Logo Sizes
  static const double logoHeightSm = 32.0;
  static const double logoHeightMd = 48.0;
  static const double logoHeightLg = 64.0;
}