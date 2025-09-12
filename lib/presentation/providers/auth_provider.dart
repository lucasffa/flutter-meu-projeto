// lib/presentation/providers/auth_provider.dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required LoginUseCase loginUseCase,
  }) : _loginUseCase = loginUseCase;

  final LoginUseCase _loginUseCase;

  AuthStatus _status = AuthStatus.initial;
  UserEntity? _user;
  String? _errorMessage;
  String? _accessToken;
  bool _rememberUser = false;

  // Getters
  AuthStatus get status => _status;
  UserEntity? get user => _user;
  String? get errorMessage => _errorMessage;
  String? get accessToken => _accessToken;
  bool get rememberUser => _rememberUser;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get isLoading => _status == AuthStatus.loading;

  // Initialize provider - check for saved credentials
  Future<void> initialize() async {
    try {
      _setStatus(AuthStatus.loading);
      
      final prefs = await SharedPreferences.getInstance();
      final savedToken = prefs.getString('access_token');
      final savedUser = prefs.getString('user_data');
      
      if (savedToken != null && savedUser != null) {
        _accessToken = savedToken;
        // Parse saved user data and validate token
        await _validateStoredSession();
      } else {
        _setStatus(AuthStatus.unauthenticated);
      }
    } catch (e) {
      _setError('Erro ao inicializar autenticação');
      _setStatus(AuthStatus.unauthenticated);
    }
  }

  // Login method
  Future<bool> login({
    required String username,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      _setStatus(AuthStatus.loading);
      _clearError();
      _rememberUser = rememberMe;

      final result = await _loginUseCase.execute(
        username: username,
        password: password,
      );

      if (result.isSuccess) {
        _user = result.user;
        _accessToken = result.accessToken;
        
        if (rememberMe) {
          await _saveCredentials();
        }
        
        _setStatus(AuthStatus.authenticated);
        return true;
      } else {
        _setError(result.errorMessage ?? 'Erro desconhecido ao fazer login');
        _setStatus(AuthStatus.unauthenticated);
        return false;
      }
    } catch (e) {
      _setError('Erro de conexão. Verifique sua internet e tente novamente.');
      _setStatus(AuthStatus.unauthenticated);
      return false;
    }
  }

  // Logout method
  Future<void> logout() async {
    try {
      _setStatus(AuthStatus.loading);
      
      // Clear local storage
      await _clearStoredCredentials();
      
      // Reset state
      _user = null;
      _accessToken = null;
      _rememberUser = false;
      
      _setStatus(AuthStatus.unauthenticated);
    } catch (e) {
      _setError('Erro ao fazer logout');
    }
  }

  // Forgot password
  Future<bool> requestPasswordReset(String email) async {
    try {
      _setStatus(AuthStatus.loading);
      
      // TODO: Implement password reset API call
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      
      _setStatus(_user != null ? AuthStatus.authenticated : AuthStatus.unauthenticated);
      return true;
    } catch (e) {
      _setError('Erro ao solicitar recuperação de senha');
      return false;
    }
  }

  // Refresh token
  Future<bool> refreshToken() async {
    try {
      if (_accessToken == null) return false;
      
      // TODO: Implement token refresh API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      
      return true;
    } catch (e) {
      await logout();
      return false;
    }
  }

  // Private methods
  void _setStatus(AuthStatus status) {
    _status = status;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> _validateStoredSession() async {
    try {
      // TODO: Validate token with API
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      
      // If token is valid, set authenticated status
      _setStatus(AuthStatus.authenticated);
    } catch (e) {
      await _clearStoredCredentials();
      _setStatus(AuthStatus.unauthenticated);
    }
  }

  Future<void> _saveCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      if (_accessToken != null) {
        await prefs.setString('access_token', _accessToken!);
      }
      
      if (_user != null) {
        // TODO: Serialize user data
        await prefs.setString('user_data', _user!.toJson());
      }
      
      await prefs.setBool('remember_user', _rememberUser);
    } catch (e) {
      debugPrint('Error saving credentials: $e');
    }
  }

  Future<void> _clearStoredCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
      await prefs.remove('user_data');
      await prefs.remove('remember_user');
    } catch (e) {
      debugPrint('Error clearing credentials: $e');
    }
  }

  // Update user profile
  void updateUser(UserEntity user) {
    _user = user;
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _clearError();
  }

}