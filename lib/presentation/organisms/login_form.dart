// lib/presentation/organisms/login_form.dart
import 'package:flutter/material.dart';
import '../molecules/brand_header.dart';
import '../molecules/form_field.dart';
import '../molecules/button_group.dart';
import '../atoms/app_logo.dart';
import '../atoms/app_text.dart';
import '../atoms/app_button.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/validators.dart';
import '../../core/constants/app_strings.dart';

class LoginFormData {
  const LoginFormData({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    this.onSubmit,
    this.onForgotPassword,
    this.isLoading = false,
    this.errorMessage,
    this.title = AppStrings.loginTitle,
    this.subtitle = AppStrings.loginSubtitle,
    this.usernameLabel = AppStrings.usernameLabel,
    this.passwordLabel = AppStrings.passwordLabel,
    this.usernamePlaceholder = AppStrings.usernamePlaceholder,
    this.passwordPlaceholder = AppStrings.passwordPlaceholder,
    this.loginButtonText = AppStrings.loginButton,
    this.forgotPasswordText = AppStrings.forgotPasswordButton,
    this.showLogo = true,
    this.logoSize = AppLogoSize.medium,
    this.spacing,
    this.formSpacing,
  });

  final Function(LoginFormData)? onSubmit;
  final VoidCallback? onForgotPassword;
  final bool isLoading;
  final String? errorMessage;
  final String title;
  final String subtitle;
  final String usernameLabel;
  final String passwordLabel;
  final String? usernamePlaceholder;
  final String? passwordPlaceholder;
  final String loginButtonText;
  final String forgotPasswordText;
  final bool showLogo;
  final AppLogoSize logoSize;
  final double? spacing;
  final double? formSpacing;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() == true) {
      final data = LoginFormData(
        username: _usernameController.text.trim(),
        password: _passwordController.text,
      );
      widget.onSubmit?.call(data);
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header com Logo e Títulos
          BrandHeader(
            title: widget.title,
            subtitle: widget.subtitle,
            showLogo: widget.showLogo,
            logoSize: AppLogoSize.medium,
            logoVariant: AppLogoVariant.svg, // Use SVG quando disponível
            titleVariant: AppTextVariant.headlineSmall,
            subtitleVariant: AppTextVariant.bodySmall,
            titleColor: AppColors.textPrimary,
            subtitleColor: AppColors.textSecondary,
          ),
          
          SizedBox(height: widget.spacing ?? AppDimensions.spacing2xl),
          
          // Campo de Usuário
          AppFormField(
            label: widget.usernameLabel,
            controller: _usernameController,
            placeholder: widget.usernamePlaceholder,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: AppValidators.required,
            enabled: !widget.isLoading,
          ),
          
          SizedBox(height: widget.formSpacing ?? AppDimensions.spacingMd),
          
          // Campo de Senha
          AppFormField(
            label: widget.passwordLabel,
            controller: _passwordController,
            placeholder: widget.passwordPlaceholder,
            obscureText: _obscurePassword,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            validator: AppValidators.required,
            enabled: !widget.isLoading,
            onSubmitted: (_) => _handleSubmit(),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey[600],
              ),
              onPressed: widget.isLoading ? null : _togglePasswordVisibility,
            ),
          ),
          
          SizedBox(height: widget.spacing ?? AppDimensions.spacingXl),
          
          // Mensagem de Erro
          if (widget.errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.all(AppDimensions.spacingSm),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                border: Border.all(color: Colors.red[200]!),
              ),
              child: AppText(
                widget.errorMessage!,
                variant: AppTextVariant.bodySmall,
                color: Colors.red[700],
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingLg),
          ],
          
          // Botões de Ação
          ButtonGroup(
            fullWidth: true,
            spacing: AppDimensions.spacingLg,
            buttons: [
              ButtonGroupItem(
                text: widget.loginButtonText,
                onPressed: widget.isLoading ? null : _handleSubmit,
                variant: AppButtonVariant.primary,
                size: AppButtonSize.large,
                isLoading: widget.isLoading,
              ),
              ButtonGroupItem(
                text: widget.forgotPasswordText,
                onPressed: widget.isLoading ? null : widget.onForgotPassword,
                variant: AppButtonVariant.text,
                size: AppButtonSize.small,
              ),
            ],
          ),
        ],
      ),
    );
  }
}