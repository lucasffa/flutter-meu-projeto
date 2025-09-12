// lib/presentation/atoms/app_input.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';

enum AppInputSize { small, medium, large }
enum AppInputVariant { outlined, filled, underlined }

class AppInput extends StatefulWidget {
  const AppInput({
    super.key,
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
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderRadius,
    this.contentPadding,
  });

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
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final double? borderRadius;
  final EdgeInsets? contentPadding;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      // Focus state change triggers rebuild
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          decoration: _getInputDecoration(),
          style: _getTextStyle(),
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          autofocus: widget.autofocus,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
        ),
        if (widget.helperText != null && widget.errorText == null)
          Padding(
            padding: const EdgeInsets.only(
              top: AppDimensions.spacingXs,
              left: AppDimensions.spacingMd,
            ),
            child: Text(
              widget.helperText!,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
      ],
    );
  }

  InputDecoration _getInputDecoration() {
    return InputDecoration(
      hintText: widget.placeholder,
      hintStyle: TextStyle(
        color: AppColors.textSecondary,
        fontSize: _getFontSize(),
      ),
      errorText: widget.errorText,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon,
      prefixText: widget.prefixText,
      suffixText: widget.suffixText,
      contentPadding: widget.contentPadding ?? _getContentPadding(),
      filled: widget.variant == AppInputVariant.filled,
      fillColor: widget.fillColor ?? _getFillColor(),
      border: _getBorder(),
      enabledBorder: _getEnabledBorder(),
      focusedBorder: _getFocusedBorder(),
      errorBorder: _getErrorBorder(),
      focusedErrorBorder: _getFocusedErrorBorder(),
      disabledBorder: _getDisabledBorder(),
    );
  }

  TextStyle _getTextStyle() {
    return TextStyle(
      fontSize: _getFontSize(),
      color: widget.enabled ? AppColors.textPrimary : AppColors.textDisabled,
      fontWeight: FontWeight.w400,
    );
  }

  double _getFontSize() {
    switch (widget.size) {
      case AppInputSize.small:
        return 12.0;
      case AppInputSize.medium:
        return 14.0;
      case AppInputSize.large:
        return 16.0;
    }
  }

  Color _getFillColor() {
    switch (widget.variant) {
      case AppInputVariant.filled:
        return AppColors.grey100;
      default:
        return Colors.transparent;
    }
  }

  EdgeInsets _getContentPadding() {
    switch (widget.size) {
      case AppInputSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingSm,
          vertical: AppDimensions.spacingXs,
        );
      case AppInputSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingMd,
          vertical: AppDimensions.spacingSm,
        );
      case AppInputSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingLg,
          vertical: AppDimensions.spacingMd,
        );
    }
  }

  double _getBorderRadius() {
    return widget.borderRadius ?? AppDimensions.radiusSm;
  }

  InputBorder _getBorder() {
    switch (widget.variant) {
      case AppInputVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.grey300,
            width: AppDimensions.borderThin,
          ),
        );
      case AppInputVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
          borderSide: BorderSide.none,
        );
      case AppInputVariant.underlined:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.grey300,
            width: AppDimensions.borderThin,
          ),
        );
    }
  }

  InputBorder _getEnabledBorder() {
    return _getBorder();
  }

  InputBorder _getFocusedBorder() {
    switch (widget.variant) {
      case AppInputVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
          borderSide: BorderSide(
            color: widget.focusedBorderColor ?? AppColors.primaryRed,
            width: AppDimensions.borderMedium,
          ),
        );
      case AppInputVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
          borderSide: BorderSide(
            color: widget.focusedBorderColor ?? AppColors.primaryRed,
            width: AppDimensions.borderMedium,
          ),
        );
      case AppInputVariant.underlined:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: widget.focusedBorderColor ?? AppColors.primaryRed,
            width: AppDimensions.borderMedium,
          ),
        );
    }
  }

  InputBorder _getErrorBorder() {
    switch (widget.variant) {
      case AppInputVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
          borderSide: BorderSide(
            color: widget.errorBorderColor ?? AppColors.error,
            width: AppDimensions.borderThin,
          ),
        );
      case AppInputVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
          borderSide: BorderSide(
            color: widget.errorBorderColor ?? AppColors.error,
            width: AppDimensions.borderThin,
          ),
        );
      case AppInputVariant.underlined:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: widget.errorBorderColor ?? AppColors.error,
            width: AppDimensions.borderThin,
          ),
        );
    }
  }

  InputBorder _getFocusedErrorBorder() {
    switch (widget.variant) {
      case AppInputVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
          borderSide: BorderSide(
            color: widget.errorBorderColor ?? AppColors.error,
            width: AppDimensions.borderMedium,
          ),
        );
      case AppInputVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
          borderSide: BorderSide(
            color: widget.errorBorderColor ?? AppColors.error,
            width: AppDimensions.borderMedium,
          ),
        );
      case AppInputVariant.underlined:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: widget.errorBorderColor ?? AppColors.error,
            width: AppDimensions.borderMedium,
          ),
        );
    }
  }

  InputBorder _getDisabledBorder() {
    switch (widget.variant) {
      case AppInputVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
          borderSide: BorderSide(
            color: AppColors.grey200,
            width: AppDimensions.borderThin,
          ),
        );
      case AppInputVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
          borderSide: BorderSide.none,
        );
      case AppInputVariant.underlined:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.grey200,
            width: AppDimensions.borderThin,
          ),
        );
    }
  }
}