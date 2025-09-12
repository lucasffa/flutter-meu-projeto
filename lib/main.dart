// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/providers/auth_provider.dart';
import 'domain/usecases/login_usecase.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Dependency Injection
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        ProxyProvider<AuthService, AuthRepositoryImpl>(
          update: (_, authService, __) => AuthRepositoryImpl(
            authService: authService,
          ),
        ),
        ProxyProvider<AuthRepositoryImpl, LoginUseCase>(
          update: (_, repository, __) => LoginUseCase(
            repository: repository,
          ),
        ),
        ChangeNotifierProxyProvider<LoginUseCase, AuthProvider>(
          create: (context) => AuthProvider(
            loginUseCase: context.read<LoginUseCase>(),
          ),
          update: (_, loginUseCase, previous) => previous ?? AuthProvider(
            loginUseCase: loginUseCase,
          ),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return MaterialApp(
            title: AppStrings.appName,
            theme: AppTheme.lightTheme,
            home: const AppInitializer(),
            routes: {
              LoginPage.routeName: (context) => const LoginPage(),
              '/dashboard': (context) => const DashboardPage(),
              '/forgot-password': (context) => const ForgotPasswordPage(),
            },
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  @override
  void initState() {
    super.initState();
    // Adiamos a inicialização para após o build ser concluído
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    final authProvider = context.read<AuthProvider>();
    await authProvider.initialize();
    
    if (mounted) {
      if (authProvider.isAuthenticated) {
        Navigator.of(context).pushReplacementNamed('/dashboard');
      } else {
        Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// Placeholder pages for demonstration
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.dashboardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final authProvider = context.read<AuthProvider>();
              await authProvider.logout();
              if (context.mounted) {
                Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
              }
            },
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${AppStrings.welcome}, ${authProvider.user?.displayName ?? 'Usuário'}!',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                const Text(AppStrings.loginSuccess),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.forgotPasswordTitle),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppStrings.forgotPasswordSubtitle),
            SizedBox(height: 16),
            Text('Implementar formulário de recuperação de senha'),
          ],
        ),
      ),
    );
  }
}