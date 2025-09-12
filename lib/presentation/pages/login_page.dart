// lib/presentation/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../templates/auth_template.dart';
import '../organisms/login_form.dart';
import '../providers/auth_provider.dart';
import '../providers/form_provider.dart';
import '../../core/constants/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late FormProvider _formProvider;

  @override
  void initState() {
    super.initState();
    _formProvider = FormProvider();
  }

  @override
  void dispose() {
    _formProvider.dispose();
    super.dispose();
  }

  void _handleLogin(LoginFormData data) async {
    final authProvider = context.read<AuthProvider>();
    
    final success = await authProvider.login(
      username: data.username,
      password: data.password,
      rememberMe: true,
    );

    if (success && mounted) {
      // Navigate to dashboard or home page
      Navigator.of(context).pushReplacementNamed('/dashboard');
    }
  }

  void _handleForgotPassword() {
    // Navigate to forgot password page
    Navigator.of(context).pushNamed('/forgot-password');
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _formProvider),
      ],
      child: AuthTemplate(
        backgroundColor: AppColors.backgroundSecondary,
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return LoginForm(
              onSubmit: _handleLogin,
              onForgotPassword: _handleForgotPassword,
              isLoading: authProvider.isLoading,
              errorMessage: authProvider.errorMessage,
            );
          },
        ),
      ),
    );
  }
}