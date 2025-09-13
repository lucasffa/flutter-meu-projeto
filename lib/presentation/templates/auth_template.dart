// lib/presentation/templates/auth_template.dart
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';

class AuthTemplate extends StatelessWidget {
  const AuthTemplate({
    super.key,
    required this.child,
    this.backgroundColor,
    this.showBackButton = false,
    this.onBackPressed,
    this.maxWidth,
    this.padding,
    this.margin,
    this.scrollable = true,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
    this.resizeToAvoidBottomInset = true,
  });

  final Widget child;
  final Color? backgroundColor;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final double? maxWidth;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool scrollable;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.backgroundPrimary,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: showBackButton ? _buildAppBar() : null,
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.textPrimary,
        ),
        onPressed: onBackPressed,
      ),
    );
  }

  Widget _buildBody() {
    Widget content = Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(AppDimensions.containerPadding),
      margin: margin,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? AppDimensions.containerMaxWidth,
          ),
          child: Card(
            elevation: 4,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacing2xl,
                vertical: AppDimensions.spacingXl,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );

    if (scrollable) {
      content = SingleChildScrollView(
        keyboardDismissBehavior: keyboardDismissBehavior,
        physics: const ClampingScrollPhysics(),
        child: content,
      );
    }

    return content;
  }
}