// lib/presentation/molecules/form_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../atoms/app_text.dart';
import '../atoms/app_input.dart';
import '../../core/constants/app_dimensions.dart';

class AppFormField extends StatelessWidget {
  const AppFormField({
    super.key,
    required this.label,
    this.controller,
    this.initialValue,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.size = AppInputSize.medium,
    this.variant = AppInputVariant.outlined,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.isRequired = false,
    this.labelVariant = AppTextVariant.labelMedium,
    this.spacing,
  });

  final String label;
  final TextEditingController? controller;
  final String? initialValue;
  final String? placeholder;
  final String? helperText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final AppInputSize size;
  final AppInputVariant variant;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final bool isRequired;
  final AppTextVariant labelVariant;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLabel(),
        SizedBox(height: spacing ?? _getDefaultSpacing()),
        AppInput(
          controller: controller,
          initialValue: initialValue,
          placeholder: placeholder,
          helperText: helperText,
          errorText: errorText,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          enabled: enabled,
          readOnly: readOnly,
          autofocus: autofocus,
          maxLines: maxLines,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          size: size,
          variant: variant,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          prefixText: prefixText,
          suffixText: suffixText,
        ),
      ],
    );
  }

  Widget _buildLabel() {
    if (isRequired) {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label,
              style: _getLabelTextStyle(),
            ),
            TextSpan(
              text: ' *',
              style: _getLabelTextStyle().copyWith(
                color: Colors.red,
              ),
            ),
          ],
        ),
      );
    }
    
    return AppText(
      label,
      variant: labelVariant,
    );
  }

  TextStyle _getLabelTextStyle() {
    switch (labelVariant) {
      case AppTextVariant.labelLarge:
        return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        );
      case AppTextVariant.labelMedium:
        return const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        );
      case AppTextVariant.labelSmall:
        return const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        );
      default:
        return const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        );
    }
  }

  double _getDefaultSpacing() {
    switch (size) {
      case AppInputSize.small:
        return AppDimensions.spacingXs;
      case AppInputSize.medium:
        return AppDimensions.spacingSm;
      case AppInputSize.large:
        return AppDimensions.spacingMd;
    }
  }
}